extends Node

@export var dir : Vector2
@export var current : Node
@export var close_dir : Vector2

@onready var state_machine = %Anim["parameters/playback"]

func _ready():
	current = %FSM.get_node("IDLE")
	%Anim.active = true
	
	var dir3 = (Variables.Player3D.global_position - $"..".global_position).normalized()
	dir = Vector2(dir3.x, dir3.z)

func _process(delta):
	
	if current.has_method("Update"):
		current.Update(delta)

	var angle = (Variables.Player3D.global_position - $"..".global_position).normalized()
	var dir2 = Vector2(angle.x, angle.z)


func _physics_process(delta):
	
	if current.has_method("Physics"):
		current.Physics(delta)




func _on_anim_animation_finished(anim_name):
	
	current = $IDLE
