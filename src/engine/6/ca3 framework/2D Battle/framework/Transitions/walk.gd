extends Node

@export var ismovement : bool = true
@onready var fireballlinearangle = Vector2i.ZERO


func Update():
	$"../Motion Transition".GetRawMotion()
	
	if Input.is_action_just_released("A"):
		$"../".ChangeMotion("PUNCH", 0)
		return
	if Input.is_action_just_released("B"):
		$"../".ChangeMotion("HADOUKEN", 0)
		return
	
	if $"../".rawmotion == Vector2i.ZERO:
		$"../".ChangeMotion("IDLE", -999)
	if Input.is_action_pressed("X"):
		$"../".ChangeMotion("JRPG DASH", -999)
