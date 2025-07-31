extends Node

func Update(delta):
	var dir = Vector2i.ZERO
	
	if Input.is_action_pressed("LEFT"):
		dir.x = -1
	if Input.is_action_pressed("RIGHT"):
		dir.x = 1
	if Input.is_action_pressed("UP"):
		dir.y = -1
	if Input.is_action_pressed("DOWN"):
		dir.y = 1
		
	if dir != Vector2i.ZERO:
		$"../".ChangeState("WALK")

func Physics(delta):
	pass
