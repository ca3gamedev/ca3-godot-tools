extends Node

const INPUT_FOLDER := "user://input"
const OUTPUT_FOLDER := "user://output"
const SCALE_FACTOR := 1
const RADIUS := SCALE_FACTOR

func _ready():
	# Ensure input folder exists
	var input_dir = DirAccess.open(INPUT_FOLDER)
	if input_dir == null:
		# Create input folder if it doesn't exist
		var root_dir = DirAccess.open("res://")
		root_dir.make_dir(INPUT_FOLDER)
		%LOG.text = "Created input folder at %s. Please add PNG files and restart." % INPUT_FOLDER
		return
	
	# Create output folder if needed
	var output_dir = DirAccess.open("res://")
	if not output_dir.dir_exists(OUTPUT_FOLDER):
		output_dir.make_dir_recursive(OUTPUT_FOLDER)
	
	# Get PNG files in input folder
	var files = []
	var dir = DirAccess.open(INPUT_FOLDER)
	dir.list_dir_begin()
	var filename = dir.get_next()
	while filename != "":
		if not dir.current_is_dir() and filename.to_lower().ends_with(".png"):
			files.append(filename)
		filename = dir.get_next()
	dir.list_dir_end()
	
	if files.size() == 0:
		%LOG.text = "No PNG files found in %s" % INPUT_FOLDER
		return

	# Process each PNG file
	for file_name in files:
		var file_path = INPUT_FOLDER + "/" + file_name
		var sprite_name = file_name.get_basename()  # filename without extension
		%LOG.text = "Processing %s..." % file_path
		var image = Image.new()
		var err = image.load(file_path)
		if err != OK:
			%LOG.text = "Failed to load image: %s" % file_path
			continue
		if image == null:
			%LOG.text = "Failed to load image: %s" % file_path
			continue
		
		# Process image and save outputs
		_process_image(image, sprite_name)

	%LOG.text = "Batch processing complete."


func _process_image(original_image: Image, sprite_name: String) -> void:
	var width = original_image.get_width()
	var height = original_image.get_height()
	var new_width = width * SCALE_FACTOR
	var new_height = height * SCALE_FACTOR

	# Create output folder for this sprite
	var sprite_folder_path = "user://output/" + sprite_name
	var dir_access = DirAccess.open("res://")
	
	if not DirAccess.dir_exists_absolute(sprite_folder_path):
		var err = DirAccess.make_dir_recursive_absolute(sprite_folder_path)
		if err != OK:
			%LOG.text = "Failed to create folder for sprite: %s" % sprite_folder_path
			return
	

	var color_layers := {}

	# Create layers for each unique color
	for y in range(height):
		for x in range(width):
			var color = original_image.get_pixel(x, y)
			if color.a < 0.01:
				continue

			if not color_layers.has(color):
				var layer = Image.create(new_width, new_height, false, Image.FORMAT_RGBA8)
				layer.fill(Color(0, 0, 0, 0))
				color_layers[color] = layer

			var center_x = int(x * SCALE_FACTOR + RADIUS)
			var center_y = int(y * SCALE_FACTOR + RADIUS)

			for dy in range(-int(RADIUS), int(RADIUS) + 1):
				for dx in range(-int(RADIUS), int(RADIUS) + 1):
					if dx * dx + dy * dy <= RADIUS * RADIUS:
						var px = center_x + dx
						var py = center_y + dy
						if px >= 0 and px < new_width and py >= 0 and py < new_height:
							color_layers[color].set_pixel(px, py, color)

	# Save each color layer as PNG in sprite folder
	var i = 0
	for color in color_layers.keys():
		var layer_image : Image = color_layers[color]
		
		var save_path = "%s/layer_%02d.png" % [sprite_folder_path, i]
		var err = layer_image.save_png(save_path)
		if err != OK:
			%LOG.text = "Failed to save layer image: %s" % save_path
		i += 1

	# Save original upscaled image (nearest neighbor 4x)
	var original_upscaled = Image.create(new_width, new_height, false, original_image.get_format())
	original_upscaled.fill(Color(0, 0, 0, 0))
	for y in range(height):
		for x in range(width):
			var color = original_image.get_pixel(x, y)
			for dy in range(SCALE_FACTOR):
				for dx in range(SCALE_FACTOR):
					var px = x * SCALE_FACTOR + dx
					var py = y * SCALE_FACTOR + dy
					original_upscaled.set_pixel(px, py, color)
	var original_upscaled_path = "%s/original_upscaled.png" % sprite_folder_path
	original_upscaled.save_png(original_upscaled_path)

	%LOG.text = "Saved processed layers and upscaled image for %s" % sprite_name
