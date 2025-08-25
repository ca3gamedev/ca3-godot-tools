extends Node


func _on_hurtbox_area_entered(area: Area3D) -> void:
	
	if area.is_in_group("Hitbox"):
		Variables.GUI.Hit(%FSM.Root.damage, get_node("../../").ID)
		
		if %FSM.OnGround:
			%FSM.current = %FSM.get_node("ATTACK")
			%FSM.current.Start("HURT")
		else:
			%FSM.current = %FSM.get_node("AIRHURT")
			if %FSM.Root.IsAI:
				%FSM.current.Start(%FSM.dir_ai.x * -1)
			else:
				%FSM.current.Start(%FSM.dir.x * -1)
		area.get_node("../..").HITSTOP()
		$"../..".HITSTOP()
	
	if area.is_in_group("HURTBOX"):
		%FSM.separation = true


func _on_hurtbox_area_exited(area: Area3D) -> void:
	
	if area.is_in_group("HURTBOX"):
		%FSM.separation = false


func _on_hitbox_area_entered(area: Area3D) -> void:
	
	if area.is_in_group("HURTBOX"):
		%FSM.current = %FSM.get_node("IDLE")
		%FSM.current.Start()
		%FSM.state.start("IDLE")
