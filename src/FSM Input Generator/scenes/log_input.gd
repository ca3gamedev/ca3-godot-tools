extends Node

func _process(delta):
	%KEYSLOG.text = str(%Buffer.dir)
	%BUTTONLOG.text = str(%Buffer.button)
	
	var children = $"../../INPUT/FSM/Move".get_children()
	if children.size() > 0:
		if is_instance_valid(children[0]):
			var move = children[0].InputCheck()
			%MovementLog.text = str(move)
	
	var buttons = $"../../INPUT/FSM/Button".GetButton()
	var button = "none"
	match(buttons.z):
		1 : button = "A"
		2 : button = "B"
		3 : button = "C"
		4 : button = "D"
		5 : button = "W"
		6 : button = "X"
		7 : button = "Y"
		8 : button = "Z"
	
	%ButtonLog.text = button + " : " + str(buttons.x) + " : " + str(buttons.y)
