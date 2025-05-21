extends Node

@export var dir : Vector2i
@export var button : String = "none"

@onready var Buffer = $"../../../Buffer"

func GetButton():
	
	var tmp = "none"
	
	if button == "A" and Buffer.Get0Button() == "A":
		tmp = button
	if button == "B" and Buffer.Get0Button() == "B":
		tmp = button
	if button == "C" and Buffer.Get0Button() == "C":
		tmp = button
	if button == "D" and Buffer.Get0Button() == "D":
		tmp = button
	if button == "W" and Buffer.Get0Button() == "W":
		tmp = button
	if button == "X" and Buffer.Get0Button() == "X":
		tmp = button
	if button == "Y" and Buffer.Get0Button() == "Y":
		tmp = button
	if button == "Z" and Buffer.Get0Button() == "Z":
		tmp = button
	
	return tmp

func GetDir():
	if dir == Buffer.raw0:
		return true
	return false
