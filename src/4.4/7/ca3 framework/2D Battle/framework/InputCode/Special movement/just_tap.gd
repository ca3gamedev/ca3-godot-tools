extends Node

@export var dir : int

func CheckInput():
	if GetCharge():
		if dir == -1 and ParryLeft():
			return "PARRY LEFT"
		if dir == 1 and ParryRight():
			return "PARRY RIGHT"
	return "none"

func ParryLeft():
	if GetDir(0, Vector2i(-1, 0)):
		return true
	return false

func ParryRight():
	if GetDir(0, Vector2i(1, 0)):
		return true
	return false

func GetCharge():
	if $"../".Buffer.charge.size() > 0 and $"../".Buffer.charge[0] < 0.2:
		return true
	return false

func GetDir(id, vector):
	if $"../".Buffer.rel_dir.size() > 1:
		return $"../".Buffer.rel_dir[id] == vector
	return false
