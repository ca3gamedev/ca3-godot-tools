extends Node

func GetMotion():
	var dir = $"../".inputnode.GetInput()
	var motion = Vector2i.ZERO
	
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
