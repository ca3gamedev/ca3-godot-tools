extends Node


func InputCheck():
	
	var dir = Vector2i.ZERO
	
	if Input.is_action_pressed("LEFT") and not Input.is_action_pressed("RIGHT"):
		dir.x = -1
	if Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT"):
		dir.x = 1
	if Input.is_action_pressed("UP") and not Input.is_action_pressed("DOWN"):
		dir.y = 1
	if Input.is_action_pressed("DOWN") and not Input.is_action_pressed("UP"):
		dir.y = -1
	
	return dir
