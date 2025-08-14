extends Node

@onready var Root = $"../.."
@onready var current_time : float
@export var max_idle_wait : float

func Update(delta):
	
	var angle = %Anim.get("parameters/MOVE/blend_position")
	angle = lerp(angle, Vector2.ZERO, delta * 2)
	%Anim.set("parameters/MOVE/blend_position", angle)
	
	var pos = Variables.Player3D.global_position
	if pos.distance_to($"../../".global_position) < 10.0:
		if pos.distance_to($"../../".global_position) > %WALK.near_distance:
			%FSM.current = %FSM.get_node("WALK")
	else:
		current_time += delta
		
		if current_time > max_idle_wait:
			current_time = 0.0
			Root.npc_target_dir = Vector2.ZERO
			Root.npc_target_dir.x = randf_range(-1, 1)
			Root.npc_target_dir.y = randf_range(-1, 1)
			%FSM.current = %FSM.get_node("NPCWALK")
	
func Physics(delta):
	pass
