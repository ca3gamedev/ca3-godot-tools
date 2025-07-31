extends Node

func GetRawMotion():
	var motion = Vector2i.ZERO
	
	if Input.is_action_pressed("LEFT"):
		motion.x = -1
	if Input.is_action_pressed("RIGHT"):
		motion.x = 1
	if Input.is_action_pressed("UP"):
		motion.y = -1
	if Input.is_action_pressed("DOWN"):
		motion.y = 1
	
	$"../".rawmotion = motion
	
	if motion != Vector2i.ZERO:
		$"../".motion = motion
