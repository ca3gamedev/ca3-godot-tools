extends Node

@export var dir : int
@export var button : String = "none"

func CheckInput():
	
	if dir == -1 and GetButton():
		if CheckLeft():
			return "Charge Left"
	if dir == 1 and GetButton():
		if CheckRight():
			return "Charge Right"
	if dir == 0 and GetButton():
		if CheckUp():
			return "Charge Up"
	return "none"
			

func CheckLeft():
	if GetDir(0, Vector2i(-1, 0)) and GetDir(1, Vector2i(1, 0)):
			return true
	if GetRaw(2, Vector2i(1, 1)) and GetDir(0, Vector2i(-1, 0)):
			return true
	return false

func CheckRight():
	if GetDir(0, Vector2i(1, 0)) and GetDir(1, Vector2i(-1, 0)):
			return true
	if GetRaw(2, Vector2i(-1, 1)) and GetDir(0, Vector2i(1, 0)):
			return true
	return false

func CheckUp():
	if GetDir(0, Vector2i(0, -1)) and GetDir(1, Vector2i(0, 1)):
		return true
	if GetDir(0, Vector2i(0, -1)) and GetRaw(2, Vector2i(-1, 1)):
		return true
	if GetDir(0, Vector2i(0, -1)) and GetRaw(2, Vector2i(1, 1)):
		return true
	return false


func GetButton():
	return $"../".Buffer.Get0Button() == button

func CheckCharge():
	if $"../".Buffer.charge[1] > 0.6:
		return true
	return false

func GetDir(id, vector):
	return $"../".Buffer.GetDir(id, vector)

func GetRaw(id, vector):
	return $"../".Buffer.GetRawDir(id) == vector
