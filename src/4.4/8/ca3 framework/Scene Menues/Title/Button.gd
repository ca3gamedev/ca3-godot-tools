extends Node2D


func _ready():
	Frame.HideCRT()
	PauseLog.HIDE()
	VariableNodes.RESETDATA()

func _process(delta):
	
	if Input.is_action_just_released("SPACE"):
		Music.PLAYSELECT()
		
		Transitions.Next = SceneDirectory.GetScreen("Save")
		Transitions.Start()
	


func _on_options_pressed():
	
	Transitions.Next = SceneDirectory.GetScreen("Options")
	Transitions.Start()
	
