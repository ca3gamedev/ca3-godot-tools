extends Node

@export var dir_x : int
@export var y : float
@export var speed_x : float
@export var gravity : float
@export var max_fall : float

func Start(x):
	dir_x = x
	y = 0

func Update(delta):
	y -= delta * gravity
	y = clampf(y, max_fall, 0)

func Physics(delta):
	var speed = delta * Vector2(dir_x * speed_x, -y) * 0.5
	
	var colision = %FSM.Root.move_and_collide(Vector3(speed.x, speed.y, 0))
	
	if colision:
		if colision.get_collider().is_in_group("GROUND"):
			%FSM.current = %FSM.get_node("IDLE")
			%FSM.current.Start()
		if colision.get_collider().is_in_group("WALL"):
			%FSM.Root.move_and_collide(Vector3(0, speed.y, 0))
	
	%FSM.Root.velocity = Vector3(speed.x, speed.y, 0)
	%FSM.Root.move_and_slide()
