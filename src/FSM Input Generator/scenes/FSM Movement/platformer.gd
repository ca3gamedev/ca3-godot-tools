extends Node

func InputCheck():
	
	var dir = "NONE"
	
	if Input.is_action_pressed("LEFT") and not Input.is_action_pressed("RIGHT"):
		dir = "LEFT"
	if Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT"):
		dir = "RIGHT"
	if get_parent().Buffer.GetJump():
		dir = "JUMP"
	if Input.is_action_pressed("UP"):
		if Input.is_action_pressed("LEFT") and not Input.is_action_pressed("RIGHT"):
			dir = "JUMP LEFT"
		if Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT"):
			dir = "JUMP RIGHT"
	if Input.is_action_pressed("DOWN"):
		dir = "CROUCH"
	
	return dir
