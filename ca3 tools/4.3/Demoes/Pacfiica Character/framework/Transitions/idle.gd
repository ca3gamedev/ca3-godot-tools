extends Node

func Update():
	var state = $"../".GetState()
	if state == "WALK":
		$"../".ChangeMotion("WALK")
	if state == "JRPG DASH":
		$"../".ClearInput()
		$"../".ChangeMotion("JRPG DASH")
