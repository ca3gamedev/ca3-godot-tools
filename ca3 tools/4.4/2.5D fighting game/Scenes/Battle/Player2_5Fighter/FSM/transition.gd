extends Node

func GetKeys():
	var dir = Vector2i.ZERO
	
	if Input.is_action_pressed("LEFT"):
		dir.x = -1
	if Input.is_action_pressed("RIGHT"):
		dir.x = 1
	if Input.is_action_pressed("LEFT") and Input.is_action_pressed("RIGHT"):
		dir.x = 0
	if Input.is_action_just_released("UP"):
		dir.y = -1
	if Input.is_action_pressed("DOWN"):
		dir.y = 1
	
	return dir

func GetButton():
	var button = "none"
	
	if Input.is_action_just_released("A"):
		button = "A"
	
	return button
