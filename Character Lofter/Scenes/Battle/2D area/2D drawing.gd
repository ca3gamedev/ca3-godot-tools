extends Control

@export var Tool: OptionButton
@export var radius: float = 10.0
@export var line_width: float = 2.0

var current := -1
var old_current := -1

var vertices: Array = []  # Array of Vector3
var edges: Array = []     # Array of Vector2i (vertex indices)
var group_selection: Array = []

var delay := false

func _process(delta):
	if delay:
		return
	
	# Get mouse position relative to this Control node
	var local_mouse_pos = get_local_mouse_position()

	# Check if inside this Control's rect
	if not get_rect().has_point(local_mouse_pos):
		return  # Ignore clicks outside this Control
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		match Tool.get_selected_id():  # assuming Tool OptionButton IDs 0=Draw,1=Extrude
			0: DrawClick()
			1: Extrude()
	
	if Input.is_action_just_released("CONNECT"):
		ConnectClick()
	
	if Input.is_action_just_released("ERASE"):
		Erase()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		current = Search_Closest()
		if Input.is_key_pressed(KEY_SHIFT):
			if current >= 0 and not group_selection.has(current):
				group_selection.append(current)
		else:
			group_selection.clear()
	
	queue_redraw()

func Search_Closest() -> int:
	var min_distance := INF
	var closest_id := -1
	var mouse_pos = get_local_mouse_position()
	
	for i in vertices.size():
		var v = vertices[i]
		var pos2d = Vector2(v.x, v.y)
		var dist = mouse_pos.distance_to(pos2d)
		if dist < min_distance:
			min_distance = dist
			closest_id = i
	return closest_id

func _draw():
	# Draw edges
	for e in edges:
		if e.x >= 0 and e.y >= 0 and e.x < vertices.size() and e.y < vertices.size():
			var v1 = vertices[e.x]
			var v2 = vertices[e.y]
			draw_line(Vector2(v1.x, v1.y), Vector2(v2.x, v2.y), Color.DARK_SLATE_BLUE, line_width)

	# Draw vertices
	for i in vertices.size():
		var v = vertices[i]
		var pos = Vector2(v.x, v.y)
		var color = Color.YELLOW
		if i == current:
			color = Color.RED
		elif group_selection.has(i):
			color = Color.BLUE
		draw_circle(pos, radius, color, true)
		draw_circle(pos, radius, color.inverted(), false, 1.0)

func DrawClick():
	var pos = Vector3(get_local_mouse_position().x, get_local_mouse_position().y, 0.0)
	vertices.append(pos)
	current = vertices.size() - 1
	delay = true
	$Delay.start(0.2)

func add_edge(a: int, b: int):
	if a == b:
		return
	if a < 0 or b < 0 or a >= vertices.size() or b >= vertices.size():
		return
	
	for e in edges:
		if (e.x == a and e.y == b) or (e.x == b and e.y == a):
			return
	edges.append(Vector2i(a, b))

func ConnectClick():
	if group_selection.size() > 1:
		add_edge(group_selection[0], group_selection[1])

func Extrude():
	if current < 0 or current >= vertices.size():
		return
	
	var mouse_pos = get_local_mouse_position()
	var new_vertex = Vector3(mouse_pos.x, mouse_pos.y, 0.0)
	vertices.append(new_vertex)
	var new_index = vertices.size() - 1
	
	add_edge(current, new_index)
	
	old_current = current
	current = new_index
	group_selection.clear()
	
	delay = true
	$Delay.start(0.2)
	
func Erase():
	# Remove selected vertices and connected edges
	# Sort indices descending so removal won't mess up earlier indices
	group_selection.sort()
	group_selection.reverse()
	
	for idx in group_selection:
		if idx >= 0 and idx < vertices.size():
			# Remove vertex
			vertices.remove_at(idx)
			
			# Remove edges connected to this vertex and update others
			for i in range(edges.size() - 1, -1, -1):
				var e = edges[i]
				if e.x == idx or e.y == idx:
					edges.remove_at(i)
				else:
					# Decrement edge indices greater than removed vertex idx
					if e.x > idx:
						e.x -= 1
					if e.y > idx:
						e.y -= 1
					edges[i] = e
	
	# Clear selection and update current index safely
	group_selection.clear()
	current = clamp(current, 0, vertices.size() - 1)

func _on_delay_timeout():
	delay = false

func GetSliceMesh():
	return vertices
