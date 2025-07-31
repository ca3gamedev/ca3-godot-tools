extends Node

@export var walk_speed : float

func Update(delta):
	var dir = Vector2i.ZERO
	
	if Input.is_action_pressed("LEFT"):
		dir.x = -1
	if Input.is_action_pressed("RIGHT"):
		dir.x = 1
	if Input.is_action_pressed("UP"):
		dir.y = -1
	if Input.is_action_pressed("DOWN"):
		dir.y = 1
		
	if dir == Vector2i.ZERO:
		$"../".ChangeState("IDLE")
	else:
		$"../".dir = dir

func Physics(delta):
	
	var speed = walk_speed * delta * $"../".dir
	$"../..".move_and_collide(speed)
