extends Node

@export var walk_speed : float

func Update(delta):
	pass

func Physics(delta):
	var speed = delta * $"../".dir * walk_speed
	$"../..".move_and_collide(Vector3(speed.x, 0, speed.y))
