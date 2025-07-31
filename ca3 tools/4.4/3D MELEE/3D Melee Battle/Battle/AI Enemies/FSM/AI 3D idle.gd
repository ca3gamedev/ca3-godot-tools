extends Node

func Update(delta):
	var angle = %Anim.get("parameters/MOVE/blend_position")
	angle = lerp(angle, Vector2.ZERO, delta * 2)
	%Anim.set("parameters/MOVE/blend_position", angle)
	
	var pos = Variables.Player3D.global_position
	if pos.distance_to($"../../".global_position) > %WALK.near_distance:
		%FSM.current = %FSM.get_node("WALK")
	
func Physics(delta):
	pass
