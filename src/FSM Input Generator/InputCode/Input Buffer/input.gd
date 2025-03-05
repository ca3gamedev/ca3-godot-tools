extends Node

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
	
	tmp = $FSM/Move.GetMove()
	var button = $FSM/Button.GetButton()
	if button[0] != "none":
		tmp = button[0] + " : " + str(button[1])
	if $FSM/Special.GetSpecial() != "none":
		tmp = $FSM/Special.GetSpecial()
	
	return tmp
