extends Node

@onready var Buffer = %Buffer


func _ready():
	owner = get_parent()

func GetSpecial():
	
	var special = "none"
	var child = get_children()
	
	for i in child:
		if i.CheckInput() != "none":
			special = i.CheckInput()
	
	return special
