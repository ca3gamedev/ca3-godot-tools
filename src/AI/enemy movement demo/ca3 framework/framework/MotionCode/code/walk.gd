extends Node

@export var ismovement : bool = true
@onready var fireballlinearangle = Vector2i.ZERO

func Physics(delta):
	var speed = delta * $"..".walk_speed * $"..".multiplier * $"../".Transition.motion
	
	$"..".Root.velocity = speed
	$"..".Root.move_and_slide()
