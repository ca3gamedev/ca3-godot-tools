extends Node

@export var Buffer : Node

func _ready():
	owner = get_parent()

func GetMove():
	var children = get_children()
	for i in children:
		return i.InputCheck()
	return "none"
