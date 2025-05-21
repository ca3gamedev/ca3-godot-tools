extends Node

@onready var motion = $"../Motion"
@onready var input = $"../INPUT"
@onready var current = $"../Motion/IDLE"

var motioninput = "NONE"

func _process(delta):
	
	var dir = input.GetInput()
	
	match (dir):
		"LEFT" : motion.dir = Vector2i.LEFT
		"RIGHT" : motion.dir = Vector2i.RIGHT
		"UP" : motion.dir = Vector2i.UP
		"DOWN" : motion.dir = Vector2i.DOWN
	
	if typeof(dir) == TYPE_VECTOR2I:
		motion.dir = dir
		motion.dir.y *= -1
		if dir == Vector2i.ZERO:
			motioninput = "IDLE"
		elif motioninput != "JRPG DASH":
			motioninput = "WALK"
	else:
		motioninput = dir
	
	if IsWalk2(dir):
		motioninput = "WALK"

func _physics_process(delta):
	current.Physics(delta)

func IsIdle():
	if motioninput == "none" or motioninput == "NONE" or motioninput == "IDLE" or motioninput == "WALK":
		return true
	return false

func IsWalk():
	if motioninput == "LEFT" or motioninput == "RIGHT" or motioninput == "UP" or motioninput == "DOWN" or motioninput == "WALK":
		return true
	return false

func IsWalk2(dir):
	if typeof(dir) == TYPE_STRING:
		if dir == "LEFT" or dir == "RIGHT" or dir == "UP" or dir == "DOWN":
			return true
	return false

func GetState():
	if typeof(motioninput) == TYPE_VECTOR2I:
		return "Vector2i"
	else:
		return motioninput

func ChangeMotion(state):
	
	match(state):
		"IDLE" : current = $"../Motion/IDLE"
		"WALK" : current = $"../Motion/WALK"
		"DASH" : current = $"../Motion/DASH"

func ClearBuffer():
	$"../INPUT/Buffer".Clear()
