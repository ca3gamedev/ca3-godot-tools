extends Node

var dir = Vector2i.DOWN
@onready var current = $IDLE

func _process(delta):
	
	current.Update(delta)

func _physics_process(delta):
	
	current.Physics(delta)

func ChangeState(state):
	match(state):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK
