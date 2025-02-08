extends Node

@export var dir : Vector2i
@export var button : String = "none"

@onready var Buffer = get_parent().Buffer

func GetButton():
	
	var tmp = Vector3i.ZERO
	if dir == Buffer.Get0Dir():
		tmp.x = dir.x
		tmp.y = dir.y
	
	if button == "A" and Buffer.Get0Button() == "A":
		tmp.z = 1
	if button == "B" and Buffer.Get0Button() == "B":
		tmp.z = 2
	if button == "C" and Buffer.Get0Button() == "C":
		tmp.z = 3
	if button == "D" and Buffer.Get0Button() == "D":
		tmp.z = 4
	if button == "W" and Buffer.Get0Button() == "W":
		tmp.z = 5
	if button == "X" and Buffer.Get0Button() == "X":
		tmp.z = 6
	if button == "Y" and Buffer.Get0Button() == "Y":
		tmp.z = 7
	if button == "Z" and Buffer.Get0Button() == "Z":
		tmp.z = 8
	
	if tmp.z != 0:
		return tmp
	return Vector3i.ZERO
