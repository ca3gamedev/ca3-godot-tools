extends Node

@onready var Root = $"../.."
@export var walk_speed : float
@export var walk_time : float

func Update(delta):
	walk_time += delta
	Root.global_rotation.y = lerp_angle(Root.global_rotation.y, atan2(Root.npc_target_dir.x, Root.npc_target_dir.y), delta * 2)
	
	if walk_time > 3.0:
		walk_time = 0.0
		%FSM.current = %FSM.get_node("IDLE")

func Physics(delta):
	
	var speed = (Variables.Player3D.global_position - Root.global_position).normalized() * walk_speed * delta
	if Root.global_position.distance_to(Vector3.ZERO) < 20:
		speed = walk_speed * delta * Vector3(Root.npc_target_dir.x, 0, Root.npc_target_dir.y)
	Root.velocity = speed
	Root.move_and_slide()
