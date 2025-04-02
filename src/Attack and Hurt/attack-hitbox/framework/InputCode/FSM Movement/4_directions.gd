extends Node


func InputCheck():
	
	var dir = "NONE"
	
	if Input.is_action_pressed("LEFT") and not Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("UP") and not Input.is_action_pressed("DOWN"):
		dir = "LEFT"
	if Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT") and not Input.is_action_pressed("UP") and not Input.is_action_pressed("DOWN"):
		dir = "RIGHT"
	if Input.is_action_pressed("UP") and not Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT") and not Input.is_action_pressed("DOWN"):
		dir = "UP"
	if Input.is_action_pressed("DOWN") and not Input.is_action_pressed("UP") and not Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT"):
		dir = "DOWN"
	
	return dir
