extends Node


func PhysicsUpdate(delta):
	$"../".player_angle = (VariableNodes.Player1.global_position - $"../../".global_position).normalized()
	
	var speed = delta * $"../".speed_walk * $"../".motion * $"../".multiplier
	if $"../../".IsHadouken:
		var lover_angle = Vector2.ZERO
		if $"../../".enemy_lover != null:
			if $"../../".enemy_lover.global_position.distance_to($"../../".global_position) > 300:
				lover_angle = ($"../../".enemy_lover.global_position - $"../../".global_position).normalized()
			if $"../../".enemy_lover.global_position.distance_to($"../../".global_position) < 50:
				lover_angle = ($"../../".born_origin - $ "../../".global_position).normalized()
		var speed2 = delta * ($"../".speed_walk * lover_angle * $"../".multiplier)
		get_parent().Root.velocity = ((speed * 0.5) + (speed2 * 0.8) )
	else:
		get_parent().Root.velocity = speed
	get_parent().Root.move_and_slide()
