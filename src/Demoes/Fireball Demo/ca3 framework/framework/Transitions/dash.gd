extends Node

@export var ismovement : bool = true

func Update():
	
	if $"../".inputnode.InputExist("A"):
		$"../".ChangeMotion("PUNCH", 0)
	
	if $"../".IsIdleDash():
		$"../".ChangeMotion("IDLE", 0)
