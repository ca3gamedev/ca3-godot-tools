extends Node

func Update():
	var state = $"../".GetState()

	if state == "JRPG DASH":
		$"../".ClearInput()
		$"../".ChangeMotion("JRPG DASH")
	if $"../".IsIdle():
		$"../".ChangeMotion("IDLE")
	
