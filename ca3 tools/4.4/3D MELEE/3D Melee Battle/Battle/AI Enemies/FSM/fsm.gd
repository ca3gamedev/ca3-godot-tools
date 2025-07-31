extends Node

@export var dir : Vector2
@export var current : Node
@export var close_dir : Vector2

func _ready():
	%Anim.active = true
	
	var dir3 = (Variables.Player3D.global_position - $"..".global_position).normalized()
	dir = Vector2(dir3.x, dir3.z)

func _process(delta):
	
	current.Update(delta)

	var angle = (Variables.Player3D.global_position - $"..".global_position).normalized()
	var dir2 = Vector2(angle.x, angle.z)
	
	$"..".global_rotation.y = lerp_angle($"..".global_rotation.y, atan2(dir2.x, dir2.y), delta * 2)

func _physics_process(delta):
	
	current.Physics(delta)
