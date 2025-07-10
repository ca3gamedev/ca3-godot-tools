extends Node

@onready var Buffer = %Buffer


func _ready():
	owner = get_parent()

func GetButton():
	
	var button = "none"
	var child = get_children()
	var dir = Vector2.ZERO
	
	for i in child:
		var id = i.GetButton()
		if id != "none" and i.GetDir():
			button = id
			dir = i.dir
	
	var result = []
	result.append(button)
	result.append(dir)
	
	return result
