extends Node

func GetMotion():
	
	var dir = $"../".inputnode.GetInput()
	var motion = Vector2i.ZERO
	
	if $"../../".PlayerID != 0:
		$"../".rawmotion = motion
		if motion != Vector2i.ZERO:
			$"../".motion = motion
		return
	
	if typeof(dir) == TYPE_STRING:
		match (dir):
			"LEFT" : motion = Vector2i.LEFT
			"RIGHT" : motion = Vector2i.RIGHT
			"UP" : motion = Vector2i.UP
			"DOWN" : motion = Vector2i.DOWN
		
		$"../".rawspecialinput = dir
		
		if dir != "none" and dir != "-999":
			$"../".specialinput = dir
	
	if typeof(dir) == TYPE_VECTOR2I:
		motion = dir
		motion.y *= -1
		
		if dir == Vector2i.ZERO:
			$"../".rawspecialinput = "IDLE"
		else:
			$"../".rawspecialinput = "WALK"
	
	$"../".rawmotion = motion
	
	if motion != Vector2i.ZERO:
		$"../".motion = motion

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
