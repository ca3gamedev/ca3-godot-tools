extends Node

func InputCheck():
	var dir = "NONE"
	
	if Input.is_action_pressed("UP") and not Input.is_action_pressed("DOWN"):
		dir = "UP"
	if Input.is_action_pressed("DOWN") and not Input.is_action_pressed("UP") :
		dir = "DOWN"
	
	return dir
