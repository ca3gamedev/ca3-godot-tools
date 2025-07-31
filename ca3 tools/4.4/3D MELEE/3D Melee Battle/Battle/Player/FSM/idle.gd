extends Node

func Start():
	pass

func Transition():
	if %TRANSITIONS.GetKey() != Vector2i.ZERO:
		%FSM.current = %FSM.get_node("WALK")
	
	if Input.is_action_just_released("A"):
		%FSM.current = %FSM.get_node("PUNCH")
		%FSM.current.Start()

func Update(delta):
	var angle = %Anim.get("parameters/MOVE/blend_position")
	angle = angle.lerp(Vector2.ZERO, delta * 2)
	%Anim.set("parameters/MOVE/blend_position", angle)

func Physics(delta):
	pass
