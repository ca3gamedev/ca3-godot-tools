extends Node

@export var dir : int
@export var button : String

func CheckInput():
	
	if dir == -1 and CheckLeft() and GetButton():
		return "2626 Left"
	if dir == 1 and CheckRight() and GetButton():
		return "2626 Right"
	return "none"
			

func CheckLeft():
	if GetDir(0, Vector2i(-1, 0)) and GetDir(1, Vector2i(0, 1)):
		if GetDir(2, Vector2i(-1, 0)) and GetDir(3, Vector2i(0, 1)):
			return true
	return false

func CheckRight():
	if GetDir(0, Vector2i(1, 0)) and GetDir(1, Vector2i(0, 1)):
		if GetDir(2, Vector2i(1, 0)) and GetDir(3, Vector2i(0, 1)):
			return true
	return false

func GetButton():
	return $"../".Buffer.Get0Button() == button

func GetDir(id, vector):
	return $"../".Buffer.GetDir(id, vector)



func GetCommandName():
	return button
