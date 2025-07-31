extends Node

@onready var current = $IDLE

@export var dir : Vector2i
@export var motiondir : Vector2i

func _process(delta):
	current.Transition(delta)
	current.Update(delta)

func _physics_process(delta):
	
	current.Physics(delta)

func ChangeState(state):
	match(state):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK
