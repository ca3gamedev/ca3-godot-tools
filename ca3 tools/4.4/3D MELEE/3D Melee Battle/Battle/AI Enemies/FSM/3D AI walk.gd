extends Node

@onready var Root = $"../.."
@export var walk_speed : float
@export var near_distance : float
@export var wavy_angle : float


func Update(delta):
	
	if Variables.Player3D.global_position.distance_to(Root.global_position) > Root.idle_distance:
		%FSM.current = %FSM.get_node("IDLE")
	
	
	wavy_angle += delta * 3
	
	var angle = %Anim.get("parameters/MOVE/blend_position")
	angle = lerp(angle, Vector2(0.5, 0), delta * 2)
	%Anim.set("parameters/MOVE/blend_position", angle)
	
	var pos = Variables.Player3D.global_position + Vector3(Root.target.x, 0, Root.target.y)
	if pos.distance_to(Root.global_position) < near_distance:
		%FSM.current = %FSM.get_node("IDLE")

func Physics(delta):

	if Root.global_position.distance_to(Variables.Player3D.global_position) < 5:
		
		if Root.global_position.distance_to(Variables.Player3D.global_position) < 1:
			%FSM.current = %FSM.get_node("IDLE")
			return
		
		var dir = (Variables.Player3D.global_position - Root.global_position).normalized()
		Root.global_rotation.y = lerp_angle(Root.global_rotation.y, atan2(dir.x, dir.y), delta * 2)
		
		var angle = (Variables.Player3D.global_position - Root.global_position).normalized()
		var speed = angle * walk_speed * delta
		
		Root.velocity = Vector3(speed.x, 0, speed.y)
		Root.move_and_slide()
		
		return
	
	Root.global_rotation.y = lerp_angle(Root.global_rotation.y, atan2(%FSM.dir.x, %FSM.dir.y), delta * 2)
	
	if %NearEnemies.final_distance < 3:
		var avoid = %FSM.close_dir * delta * walk_speed
		Root.velocity = Vector3(avoid.x, 0, avoid.y) * 0.15
		Root.move_and_slide()
	
	var pos = Variables.Player3D.global_position + Vector3(Root.target.x, 0, Root.target.y)
	var target = (pos - Root.global_position).normalized()
	var speed = target * delta * walk_speed
	
	if Root.wavy:
		var angle = (Variables.Player3D.global_position - Root.global_position).normalized()
		angle = sin(wavy_angle) * Root.wavy_amplitude * angle
		Root.velocity = Vector3(speed.x, 0, speed.z) + Vector3(angle.x, 0, angle.z) * 0.5
	else:
		var angle = (Variables.Player3D.global_position - Root.global_position).normalized()
		angle = sin(wavy_angle) * Root.wavy_amplitude * angle
		Root.velocity = Vector3(speed.x, 0, speed.z) + Vector3(angle.x * 0.2, 0, angle.z * 0.2)
	
	Root.move_and_slide()
