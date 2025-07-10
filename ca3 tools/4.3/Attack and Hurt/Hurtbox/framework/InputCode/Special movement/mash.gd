extends Node

@export var button : String = "none"

func CheckInput():
	if CheckMyButton(0) and CheckMyButton(1) and CheckMyButton(2):
		return "MASH " + button
	return "none"

func CheckMyButton(id):
	if $"../".Buffer.button.size() > 2:
		if $"../".Buffer.button[id] == button:
			return true
	return false
