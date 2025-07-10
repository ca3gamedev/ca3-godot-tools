extends Node
class_name PlayerInput

@export var input_buffer: NodePath
@onready var buffer: InputBuffer = get_node(input_buffer)

func _process(_delta):
	# Jump
	if Input.is_action_just_pressed("UP"):
		buffer.buffer_input("jump")

	# Move Left / Right
	if Input.is_action_pressed("LEFT"):
		buffer.buffer_input("move_left")

	if Input.is_action_pressed("RIGHT"):
		buffer.buffer_input("move_right")

	# (Optional) Crouch
	if Input.is_action_pressed("DOWN"):
		buffer.buffer_input("crouch")
