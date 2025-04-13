extends Area2D

@export var Transition : Node

func HIT(hitstun):
	Transition.ChangeMotion("WEAK HURT")

func GetID():
	return $"../".PlayerID
