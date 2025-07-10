extends Node

func InputCheck():
	var dir = "NONE"
	
	if Input.is_action_pressed("LEFT") and not Input.is_action_pressed("RIGHT"):
		dir = "LEFT"
	if Input.is_action_pressed("RIGHT") and not  Input.is_action_pressed("LEFT") :
		dir = "RIGHT"
	
	return dir
