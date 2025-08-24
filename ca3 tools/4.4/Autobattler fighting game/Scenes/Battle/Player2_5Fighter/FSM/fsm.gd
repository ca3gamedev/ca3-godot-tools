extends Node

@export var Root : CharacterBody3D
@export var Parent : Node3D
@export var current : Node
@export var raw_dir : Vector2i
@export var dir : Vector2i
@export var raw_dir_ai : Vector2i
@export var dir_ai : Vector2i

@onready var state = %Ani["parameters/playback"]

@export var separation : bool
@export var Ground : float
@export var OnGround : bool

func _ready() -> void:
	Ground = Root.global_position.y
	if get_parent().IsP1:
		dir = Vector2i.RIGHT
		dir_ai = Vector2i.RIGHT
	else:
		dir_ai = Vector2i.LEFT
		dir = Vector2i.LEFT
	
	await get_tree().process_frame
	Root.move_and_collide(Vector3(dir.x, 0, 0))
	%Ani.active = true
	
func _process(delta: float) -> void:
	
	if Root.global_position.y <= Ground:
		OnGround = true
	else:
		OnGround = false
	
	if current.has_method("Update"):
		current.Update(delta)
	
	if Root.IsAI:
		Parent.rotation.y = lerp_angle(Parent.rotation.y, atan2(dir_ai.x, dir_ai.y), delta * 4)
	else:
		Parent.rotation.y = lerp_angle(Parent.rotation.y, atan2(dir.x, dir.y), delta * 4)
	
	if separation:
		var direction = Vector3.ZERO
		if Root.IsAI:
			direction = (Root.global_position - Root.Player.global_position).normalized()
		else:
			if Root.Closest != null:
				direction = (Root.global_position - Root.Closest.global_position).normalized()
		direction.y = - 5.0 * delta
		var speed = 5.0 * delta * direction
		Root.move_and_collide(speed)

func _physics_process(delta: float) -> void:
		
	if current.has_method("Physics"):
		current.Physics(delta)
