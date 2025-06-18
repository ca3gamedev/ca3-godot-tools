extends Node2D

@export var Next : String

func _ready():
	Music.STOPSONG()
	$SCORE.text = str(VariableNodes.Level - 1)


func _process(delta):
	
	if Input.is_action_just_released("SPACE"):
		Music.PLAYSELECT()
		get_tree().change_scene_to_file(Next)
