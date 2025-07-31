extends Node

@export var walk_speed : float

func Start():
	pass

func Transition():
	if %TRANSITIONS.GetKey() == Vector2i.ZERO:
		%FSM.current = %FSM.get_node("IDLE")
	
	if Input.is_action_just_released("A"):
		%FSM.current = %FSM.get_node("PUNCH")
		%FSM.current.Start()

func Update(delta):
	
	var dir = %TRANSITIONS.GetKey()
	%FSM.dir = dir
	
	var angle = %Anim.get("parameters/MOVE/blend_position")
	angle = lerp(angle, Vector2(0, 0.5), delta * 2)
	%Anim.set("parameters/MOVE/blend_position", angle)

func Physics(delta):
	
	var speed = delta * walk_speed * %FSM.dir
	$"../..".velocity = Vector3(speed.x, 0, speed.y)
	$"../..".move_and_slide()
