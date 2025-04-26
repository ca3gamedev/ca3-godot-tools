extends Node

@export var checkA : bool
@export var checkB : bool
@export var checkC : bool
@export var checkD : bool
@export var checkW : bool
@export var checkX : bool
@export var checkY : bool
@export var checkZ : bool

@onready var buffer = $"../Buffer"

func _process(delta):
	
	pass
	#if $"../../".PlayerID == 0:
	#		buffer.AddDir(GetDir())
	#		buffer.AddButton(GetButton())
	
func GetDir():
	var dir = Vector2i.ZERO
	
	if Input.is_action_pressed("LEFT"):
		dir.x = -1
	if Input.is_action_pressed("RIGHT"):
		dir.x = 1
	if Input.is_action_pressed("UP"):
		dir.y = -1
	if Input.is_action_pressed("DOWN"):
		dir.y = 1
	if Input.is_action_just_released("LEFT"):
		dir.x = -2
	if Input.is_action_just_released("RIGHT"):
		dir.x = 2
	if Input.is_action_just_released("DOWN"):
		dir.y = 2
	if Input.is_action_just_released("UP"):
		dir.y = -2
	
	return dir

func GetButton():
	var button = "none"
	
	if checkA and Input.is_action_just_released("A"):
		button = "A"
	if checkB and Input.is_action_just_released("B"):
		button = "B"
	if checkC  and Input.is_action_just_released("C"):
		button = "C"
	if checkD and Input.is_action_just_released("D"):
		button = "D"
	if checkW and Input.is_action_just_released("W"):
		button = "W"
	if checkX and Input.is_action_just_released("X"):
		button = "X"
	if checkY and Input.is_action_just_released("Y"):
		button = "Y"
	if checkZ and Input.is_action_just_released("Z"):
		button = "Z"
	
	return button
