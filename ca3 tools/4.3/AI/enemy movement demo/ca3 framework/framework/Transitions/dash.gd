extends Node

@export var ismovement : bool = true

func Update():
	
	if $"../".inputnode.InputExist("A"):
		$"../".ChangeMotion("PUNCH", 0)
		return
	if $"../".inputnode.InputExist("B"):
		$"../".ChangeMotion("HADOUKEN", 0)
		return
	
	if $"../".IsIdleDash():
		$"../".ChangeMotion("IDLE", 0)
