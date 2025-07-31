extends Node

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
		
	if motiondir != Vector2i.ZERO:
		$"../".ChangeState("WALK")

func Update(delta):
	%Anim.set("parameters/MOVE/blend_position", $"../".dir * 0.5)

func Physics(delta):
	pass
