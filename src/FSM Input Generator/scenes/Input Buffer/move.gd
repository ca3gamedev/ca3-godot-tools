extends Node

@export var Buffer : Node

func GetMove():
	return $Movement.InputCheck()
