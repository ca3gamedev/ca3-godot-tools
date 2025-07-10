extends Node

@export var buffer : Node

func InputExist(new_input):
	
	if $FSM/Move.GetMove() == new_input:
		return true
	if $FSM/Button.GetButton() == new_input:
		return true
	if $FSM/Special.GetSpecial() == new_input:
		return true
	
	return false

func GetInput():
	
	var tmp = "none"
	
	var move = $FSM/Move.GetMove()
	
	if not typeof(move) == TYPE_VECTOR2I:
		if move != "NONE" or move != "none":
			tmp = move
		else:
			if buffer.charge.size() > 0:
				if buffer.charge[0] > 0.5:
					tmp = "none"
			else:
					tmp = "-999"
	else:
		if move == Vector2i.ZERO:
			if buffer.charge.size() > 0:
				if buffer.charge[0] > 0.5:
					tmp = "none"
			else:
					tmp = "-999"
		else:
			tmp = move
	var button = $FSM/Button.GetButton()
	if button[0] != "none":
		tmp = button[0] + " : " + str(button[1])
	if $FSM/Special.GetSpecial() != "none":
		tmp = $FSM/Special.GetSpecial()
	
	return tmp
