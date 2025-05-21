extends Area2D

@export var Transition : Node

func _ready():
	Transition = %Transitions

func HIT(hitstun):
	Transition.ChangeMotion("WEAK HURT", -999)

func GetID():
	return $"../".PlayerID
