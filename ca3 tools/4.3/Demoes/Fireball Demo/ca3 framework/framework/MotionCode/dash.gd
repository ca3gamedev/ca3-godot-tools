extends Node

func Physics(delta):
	var speed = delta * $"..".dash * $"..".multiplier  * $"../".Transition.motion
	
	$"../".Root.velocity = speed
	$"..".Root.move_and_slide()
