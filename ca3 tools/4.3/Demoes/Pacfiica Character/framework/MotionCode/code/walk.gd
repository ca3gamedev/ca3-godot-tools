extends Node

func Physics(delta):
	var speed = delta * $"..".walk_speed * $"..".multiplier * $"../".Transition.motion
	
	$"..".Root.velocity = speed
	$"..".Root.move_and_slide()
