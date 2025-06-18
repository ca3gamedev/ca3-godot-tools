extends Node2D


func _ready():
	PauseLog.HIDE()
	VariableNodes.RESETDATA()

func _process(delta):
	
	if Input.is_action_just_released("SPACE"):
		Music.PLAYSELECT()
		get_tree().change_scene_to_file(SceneDirectory.GetScreen("Tutorial"))
	
