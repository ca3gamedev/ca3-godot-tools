extends Node

@export var dir_x : int
@export var speed : Vector2

func Start(x):
	dir_x = x
	%FSM.state.start("JumpFHurt")

func Physics(delta):
	var speed = Vector3(speed.x * dir_x, speed.y, 0) * delta
	
	%FSM.Root.move_and_collide(speed)
