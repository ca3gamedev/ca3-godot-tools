extends Camera3D

@export var target: Vector3 = Vector3.ZERO
@export var distance := 10.0
@export var min_distance := 2.0
@export var max_distance := 50.0

@export var rotation_speed := 0.01
@export var zoom_speed := 1.2

var rotation_x := 0.0  # vertical rotation (pitch)
var rotation_y := 0.0  # horizontal rotation (yaw)

func _ready():
	# Optional: Lock the mouse to screen when rotating
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	# Rotate around target with Right Mouse Button
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		rotation_y -= event.relative.x * rotation_speed
		rotation_x -= event.relative.y * rotation_speed
		rotation_x = clamp(rotation_x, -PI / 2 + 0.01, PI / 2 - 0.01)  # avoid flipping

	# Zoom in/out with mouse wheel
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
		distance = max(distance / zoom_speed, min_distance)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
		distance = min(distance * zoom_speed, max_distance)

func _process(delta):
	# Calculate the new camera position based on spherical coordinates
	var offset = Vector3(
		distance * cos(rotation_x) * sin(rotation_y),
		distance * sin(rotation_x),
		distance * cos(rotation_x) * cos(rotation_y)
	)
	global_position = target + offset
	look_at(target, Vector3.UP)
