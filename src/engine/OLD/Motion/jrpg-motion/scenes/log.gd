extends Label

func _process(delta):
	self.text = str($"../Player/MotionTransition".motioninput)
