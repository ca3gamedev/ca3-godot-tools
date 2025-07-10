extends Node

var fsm: FSM

func _ready():
	fsm = get_parent()

func _transition():
	if fsm.input_buffer.consume_input("jump"):
		fsm.change_state("jump")
	elif fsm.input_buffer.consume_input("hop"):
		fsm.change_state("hop")
	elif fsm.input_buffer.consume_input("dash"):
		fsm.change_state("dash")
	elif fsm.input_buffer.consume_input("move_left") or fsm.input_buffer.consume_input("move_right"):
		fsm.change_state("walk")

func _physics_update(delta):
	pass  # Optional physics logic

func _handle_input(event):
	if Input.is_action_just_pressed("ui_right"):
		fsm.change_state("Run")
