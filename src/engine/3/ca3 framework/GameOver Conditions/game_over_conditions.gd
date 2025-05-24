extends Node

@export var Next : String

func _on_timer_timeout():
	var enemies = get_tree().get_nodes_in_group("ENEMY").size()
	
	if enemies <= 1 or VariableNodes.HP < 1:
		get_tree().change_scene_to_file(Next)
