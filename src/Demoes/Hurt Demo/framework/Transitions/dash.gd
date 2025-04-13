extends Node

func Update():
	
	if $"../".inputnode.InputExist("A"):
		$"../".ChangeMotion("PUNCH")
	
	if $"../".IsIdleDash():
		$"../".ChangeMotion("IDLE")
