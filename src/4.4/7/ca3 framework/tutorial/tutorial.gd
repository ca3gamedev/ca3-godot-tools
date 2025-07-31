extends Node

func _process(delta):
	
	if Input.is_action_just_released("SPACE"):
		Transitions.Next = SceneDirectory.GetScreen("Intro")
		VariableNodes.battle_won = true
		Transitions.Start()
