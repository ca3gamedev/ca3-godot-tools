extends Node

@export var dir : Vector2i
@export var button : String = "none"

func CheckInput():

	if dir == Vector2i.ZERO and CheckJRPGDash():
		return "JRPG DASH"
	
	if CheckDash():
		if button == "none":
			return str(dir)
		
		if GetButton():
			return "DASH " + button
	return "none"
	

func GetButton():
	return $"../".Buffer.Get0Button() == button


func CheckJRPGDash():
	if $"../".Buffer.rel_dir.size() > 1 and $"../".Buffer.dia_dir.size() > 0:
		if $"../".Buffer.last_release_time < 0.2 :
			return $"../".Buffer.rel_dir[1] == $"../".Buffer.dia_dir[0]
	return false

func CheckDash():
	if GetDir(0, dir) and GetUpDir(0, dir):
		return true
	return false


func GetUpDir(id, vector):
	if $"../".Buffer.rel_dir.size() > 1:
		return $"../".Buffer.rel_dir[id] == vector
	return false

func GetDir(id, vector):
	if $"../".Buffer.rel_dir.size() > 1:
		return $"../".Buffer.dia_dir[id] == vector
	return false
