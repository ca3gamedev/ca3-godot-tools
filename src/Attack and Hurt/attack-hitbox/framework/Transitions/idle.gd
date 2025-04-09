extends Node

func Update():
	
	if $"../".inputnode.InputExist("A"):
		$"../".ChangeMotion("PUNCH")
		return
	
	var state = $"../".GetState()
	if state == "WALK":
		$"../".ChangeMotion("WALK")
	if state == "JRPG DASH":
		$"../".ClearInput()
		$"../".ChangeMotion("JRPG DASH")
	
	
