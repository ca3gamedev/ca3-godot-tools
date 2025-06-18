extends Node

@export var Next : String


func _process(delta):
	
	if Input.is_action_just_released("SPACE"):
		Transitions.End()
		get_tree().change_scene_to_file(Next)
