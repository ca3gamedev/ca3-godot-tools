extends Node2D

@export var Next : String

func _ready():
	PauseLog.HIDE()
	VariableNodes.RESETDATA()

func _process(delta):
	
	if Input.is_action_just_released("SPACE"):
		Music.PLAYSELECT()
		Music.PLAYSONG()
		get_tree().change_scene_to_file(Next)
	
