extends Node


func PhysicsUpdate(delta):
	$"../".player_angle = (VariableNodes.Player1.global_position - $"../../".global_position).normalized()
	
	var speed = delta * $"../".speed_walk * $"../".motion * $"../".multiplier
	get_parent().Root.velocity = speed
	get_parent().Root.move_and_slide()
