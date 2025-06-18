extends Node

@export var walk_speed : float

func Transition(delta):
	
	var motiondir = Vector2i.ZERO
	
	if Input.is_action_pressed("LEFT"):
		motiondir.x = -1
	if Input.is_action_pressed("RIGHT"):
		motiondir.x = 1
	if Input.is_action_pressed("UP"):
		motiondir.y = -1
	if Input.is_action_pressed("DOWN"):
		motiondir.y = 1   
	
	if motiondir == Vector2i.ZERO:
		$"../".ChangeState("IDLE")

func Update(delta):
	
	%Anim.set("parameters/MOVE/blend_position", $"../".dir)
	
	var motiondir = Vector2i.ZERO
	
	if Input.is_action_pressed("LEFT"):
		motiondir.x = -1
	if Input.is_action_pressed("RIGHT"):
		motiondir.x = 1
	if Input.is_action_pressed("UP"):
		motiondir.y = -1
	if Input.is_action_pressed("DOWN"):
		motiondir.y = 1   
	
	if motiondir != Vector2i.ZERO:
		$"../".dir = motiondir 

func Physics(delta):
	var angle = delta * walk_speed * $"../".dir
	$"../..".move_and_collide(Vector3(angle.x, 0, angle.y)) 
