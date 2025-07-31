extends Camera3D

func _process(delta):
	
	get_parent().global_position = get_parent().global_position.slerp(VariableNodes.Player1_3D.global_position, delta)
