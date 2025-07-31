extends Node

var layer_images = []
var layer_colors = []
var sorted_palette_colors = []
var current_layer_index := 0

const SWATCH_SIZE := 16
const PALETTE_COLUMNS := 8

var original_upscaled_image: Image
var showing_original := false

var showing_smoothed := false
var smoothed_image: Image = null

func ready():
	var original_image := Image.load_from_file("res://2D/Athena.png")
	if original_image == null:
		push_error("Failed to load image.")
		return

	var width := original_image.get_width()
	var height := original_image.get_height()
	var scale_factor := 1
	var radius := scale_factor
	var new_width := width * scale_factor
	var new_height := height * scale_factor

	var color_layers := {}

	# Create Layers folder if it doesn't exist
	
	var dir_access = DirAccess.open("res://")
	if not dir_access.dir_exists("Layers"):
		dir_access.make_dir("Layers")
	
	# Generate color layers
	for y in range(height):
		for x in range(width):
			var color := original_image.get_pixel(x, y)
			if color.a < 0.01:
				continue

			if not color_layers.has(color):
				var layer := Image.create(new_width, new_height, false, Image.FORMAT_RGBA8)
				layer.fill(Color(0, 0, 0, 0))
				color_layers[color] = layer

			var center_x := int(x * scale_factor + radius)
			var center_y := int(y * scale_factor + radius)

			for dy in range(-int(radius), int(radius) + 1):
				for dx in range(-int(radius), int(radius) + 1):
					if dx * dx + dy * dy <= radius * radius:
						var px := center_x + dx
						var py := center_y + dy
						if px >= 0 and px < new_width and py >= 0 and py < new_height:
							color_layers[color].set_pixel(px, py, color)

	# Sort colors by brightness
	var sorted_palette_colors = color_layers.keys()
	sorted_palette_colors.sort_custom(func(a, b):
		return (a.r + a.g + a.b) < (b.r + b.g + b.b)
	)

	# Save each color layer to Layers folder with numbered names
	var i := 0
	for color in sorted_palette_colors:
		var layer_image : Image = color_layers[color]
		var file_path = "res://Layers/layer_%02d.png" % i
		var err = layer_image.save_png(file_path)
		if err != OK:
			push_error("Failed to save layer image: %s" % file_path)
		i += 1
	
	# Optionally, also save the original upscaled image
	var original_upscaled_image = Image.create(new_width, new_height, false, original_image.get_format())
	original_upscaled_image.fill(Color(0, 0, 0, 0))

	for y in range(height):
		for x in range(width):
			var color = original_image.get_pixel(x, y)
			for dy in range(scale_factor):
				for dx in range(scale_factor):
					var px = x * scale_factor + dx
					var py = y * scale_factor + dy
					original_upscaled_image.set_pixel(px, py, color)
	original_upscaled_image.save_png("res://Layers/original_upscaled.png")

	# Store layers and colors for display if needed
	layer_images.clear()
	layer_colors.clear()
	for color in sorted_palette_colors:
		layer_images.append(color_layers[color])
		layer_colors.append(color)

	_show_layer(0)


func _input(event):
	if Input.is_action_just_pressed("RIGHT"):
		_change_layer(1)
	elif Input.is_action_just_pressed("LEFT"):
		_change_layer(-1)
	elif Input.is_action_just_pressed("ORIGINAL"):
		if showing_original:
			_show_layer(current_layer_index)
			showing_original = false
		else:
			_show_original()
			showing_original = true

func _show_original():
	var texture = ImageTexture.create_from_image(original_upscaled_image)
	%Sprite.texture = texture

	# Show palette with no highlight since it's full image
	var palette_img = generate_palette_with_highlight(sorted_palette_colors, Color(0,0,0,0)) # no highlight
	var palette_tex = ImageTexture.create_from_image(palette_img)
	%PaletteSprite.texture = palette_tex

func _show_smoothed():
	if smoothed_image == null:
		# Background color detection (or define it manually)
		var color_counts := {}

		for y in range(original_upscaled_image.get_height()):
			for x in range(original_upscaled_image.get_width()):
				var col := original_upscaled_image.get_pixel(x, y)
				if col.a > 0.9:
					color_counts[col] = color_counts.get(col, 0) + 1

		var bg_color := Color(0, 0, 0, 0)
		var max_count := 0
		for color in color_counts.keys():
			if color_counts[color] > max_count:
				bg_color = color
				max_count = color_counts[color]
		smoothed_image = smooth_character_pixels(original_upscaled_image, bg_color)

	var texture = ImageTexture.create_from_image(smoothed_image)
	%Sprite.texture = texture

	# Optional: dim palette or show empty one
	var palette_img := generate_palette_with_highlight(sorted_palette_colors, Color(0, 0, 0, 0))
	var palette_tex := ImageTexture.create_from_image(palette_img)
	%PaletteSprite.texture = palette_tex

func _change_layer(delta: int):
	current_layer_index = wrapi(current_layer_index + delta, 0, layer_images.size())
	_show_layer(current_layer_index)

func _show_layer(index: int):
	if index >= 0 and index < layer_images.size():
		var image = layer_images[index]
		var texture := ImageTexture.create_from_image(image)
		%Sprite.texture = texture

		var selected_color = layer_colors[index]
		var palette_img = generate_palette_with_highlight(sorted_palette_colors, selected_color)
		if palette_img != null:
			var palette_tex = ImageTexture.create_from_image(palette_img)
			%PaletteSprite.texture = palette_tex

func generate_palette_with_highlight(colors: Array, selected_color: Color, swatch_size := SWATCH_SIZE, columns := PALETTE_COLUMNS) -> Image:
	var rows := int(ceil(colors.size() / float(columns)))
	var palette_width := columns * swatch_size
	var palette_height := rows * swatch_size
	
	if palette_height == 0 or palette_width == 0:
		return

	var image := Image.create(palette_width, palette_height, false, Image.FORMAT_RGBA8)
	image.fill(Color(0, 0, 0, 0))

	for i in range(colors.size()):
		var color = colors[i]
		var col := i % columns
		var row := i / columns
		var x0 := col * swatch_size
		var y0 := row * swatch_size

		# Fill swatch
		for y in range(swatch_size):
			for x in range(swatch_size):
				image.set_pixel(x0 + x, y0 + y, color)

		# If this is the selected color, draw white border
		if color == selected_color:
			for x in range(swatch_size):
				image.set_pixel(x0 + x, y0, Color.WHITE)
				image.set_pixel(x0 + x, y0 + swatch_size - 1, Color.WHITE)
			for y in range(swatch_size):
				image.set_pixel(x0, y0 + y, Color.WHITE)
				image.set_pixel(x0 + swatch_size - 1, y0 + y, Color.WHITE)

	return image

func color_distance(c1: Color, c2: Color) -> float:
	return sqrt(pow(c1.r - c2.r, 2) + pow(c1.g - c2.g, 2) + pow(c1.b - c2.b, 2))

func smooth_character_pixels(image: Image, background_color: Color, blur_radius := 2) -> Image:
	var width := image.get_width()
	var height := image.get_height()
	var smoothed := image.duplicate()

	for y in range(height):
		for x in range(width):
			var current_color = image.get_pixel(x, y)

			# Skip background pixels; only smooth non-background (character) pixels
			if color_distance(current_color, background_color) >= 0.05 and current_color.a > 0.05:
				var acc = Color(0, 0, 0, 0)
				var count = 0

				for dy in range(-blur_radius, blur_radius + 1):
					for dx in range(-blur_radius, blur_radius + 1):
						var nx = x + dx
						var ny = y + dy

						if nx >= 0 and nx < width and ny >= 0 and ny < height:
							var neighbor_color = image.get_pixel(nx, ny)
							if color_distance(neighbor_color, background_color) >= 0.05 and neighbor_color.a > 0.05:
								acc += neighbor_color
								count += 1

				if count > 0:
					smoothed.set_pixel(x, y, acc / count)

	return smoothed

func color_distance2(a: Color, b: Color) -> float:
	var diff = a - b
	return Vector3(diff.r, diff.g, diff.b).length()

func pixel_smooth_cpu(src_image: Image, threshold: float = 0.1, aa_scale: float = 4.0) -> Image:
	var w = src_image.get_width()
	var h = src_image.get_height()
	var dst = src_image.duplicate()

	for y in range(h):
		for x in range(w):
			var c = src_image.get_pixel(x, y)
			var colors = [c]
			for dy in [-1, 0, 1]:
				for dx in [-1, 0, 1]:
					if dx == 0 and dy == 0:
						continue
					var nx = x + dx
					var ny = y + dy
					if nx >= 0 and nx < w and ny >= 0 and ny < h:
						colors.append(src_image.get_pixel(nx, ny))
			var avg = Color(0,0,0,0)
			for col in colors:
				avg += col
			avg /= float(colors.size())
			# Blend if edge-like
			if color_distance(c, avg) > threshold:
				dst.set_pixel(x, y, avg.lerp(c, 1.0 / aa_scale))
	return dst
