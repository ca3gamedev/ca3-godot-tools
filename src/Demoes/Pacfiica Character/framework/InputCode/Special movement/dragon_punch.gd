extends Node

@export var dir : int
@export var button : String = "none"

func CheckInput():
	
	if dir == -1 and CheckLeft() and GetButton():
		return "Dragon Punch Left"
	if dir == 1 and CheckRight() and GetButton():
		return "Dragon Punch Right"
	return "none"

func CheckLeft():
	if GetDir(0, Vector2i(-1, 0)) and GetDir(1, Vector2i(0, 1)) and GetDir(2, Vector2i(-1, 0)) :
		return true
	return false

func CheckRight():
	if GetDir(0, Vector2i(1, 0)) and GetDir(1, Vector2i(0, 1)) and GetDir(2, Vector2i(1, 0)) :
		return true
	return false


func GetButton():
	return $"../".Buffer.Get0Button() == button

func GetDir(id, vector):
	return $"../".Buffer.GetDir(id, vector)
