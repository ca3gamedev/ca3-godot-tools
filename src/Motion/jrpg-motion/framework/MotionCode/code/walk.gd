extends Node

func Physics(delta):
	var speed = delta * $"..".dir * $"..".walk_speed * $"..".multiplier
	
	$"../".Root.velocity = speed
	$"..".Root.move_and_slide()
	
	if $"../".Transition.IsIdle():
		$"../".Transition.ChangeMotion("IDLE")
