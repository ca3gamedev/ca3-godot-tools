extends Node

@export var dir_x : int
@export var jump_speed : Vector2
@export var y : float
@export var gravity : float
@export var max_fall : float

func Update(delta):
	y -= delta * gravity
	
	if y < 0:
		%FSM.current = %FSM.get_node("FALL")
		%FSM.current.Start(dir_x)

func Start(x):
	y = jump_speed.y
	dir_x = x.x
	if x.x == 0:
		%FSM.state.travel("JUMP")
	else:
		%FSM.state.travel("Jump F")

func Physics(delta):
	var speed = delta * Vector2(dir_x * jump_speed.x, y)
	speed.y = clampf(speed.y, max_fall, jump_speed.y)
	
	var colision = %FSM.Root.move_and_collide(Vector3(speed.x, speed.y, 0))
	
	if colision:
		if colision.get_collider().is_in_group("WALL"):
			%FSM.Root.move_and_collide(Vector3(0, speed.y, 0))
		if colision.get_collider().is_in_group("PLAYER"):
			%FSM.Root.velocity = Vector3(speed.x, speed.y, 0)
			%FSM.Root.move_and_slide()
