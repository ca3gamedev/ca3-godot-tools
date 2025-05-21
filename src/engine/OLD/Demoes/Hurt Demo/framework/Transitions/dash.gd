extends Node

func Update():
	
	if $"../".inputnode.InputExist("A"):
		$"../".ChangeMotion("PUNCH", 0)
	
	if $"../".IsIdleDash():
		$"../".ChangeMotion("IDLE", 0)
