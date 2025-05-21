extends Node

func Physics(delta):
	var speed = delta * $"..".dir * $"..".dash * $"..".multiplier
	
	$"../".Root.velocity = speed
	$"..".Root.move_and_slide()
	if $"../".Transition.IsIdle():
		$"../".Transition.ClearBuffer()
		$"../".Transition.ChangeMotion("IDLE")
