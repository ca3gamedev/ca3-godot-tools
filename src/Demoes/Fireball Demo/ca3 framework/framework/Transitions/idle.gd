extends Node

@export var ismovement : bool = true

func Update():
	
	if $"../".inputnode.InputExist("A"):
		$"../".ChangeMotion("PUNCH", 0)
		return
	
	var state = $"../".GetState()
	if state == "WALK":
		$"../".ChangeMotion("WALK", -999)
	if state == "JRPG DASH":
		$"../".ClearInput()
		$"../".ChangeMotion("JRPG DASH", -999)
	
	
