extends Node

@onready var Buffer = %Buffer

func GetButton():
	
	var button = Vector3i.ZERO
	var child = get_children()
	
	for i in child:
		var id = i.GetButton()
		if id.z != 0:
			button = id
	
	return button
