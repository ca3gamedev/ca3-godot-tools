extends Node

@export var ismovement : bool = true
@onready var fireballlinearangle = Vector2i.ZERO

func Update():
	
	if $"../".inputnode.InputExist("A"):
		$"../".ChangeMotion("PUNCH", 0)
		return
	if $"../".inputnode.InputExist("B"):
		$"../".ChangeMotion("HADOUKEN", 0)
		return
		
	var state = $"../".GetState()

	if state == "JRPG DASH":
		$"../".ClearInput()
		$"../".ChangeMotion("JRPG DASH", -999)
	if $"../".IsIdle():
		$"../".ChangeMotion("IDLE", -999)
