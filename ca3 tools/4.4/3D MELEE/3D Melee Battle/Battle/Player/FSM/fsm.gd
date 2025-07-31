extends Node

@export var current : Node
@export var dir : Vector2i

@onready var state_machine = %Anim["parameters/playback"]

func _ready():
	%Anim.active = true

func _process(delta):
	
	if current.has_method("Transition"):
		current.Transition()
	if current.has_method("Update"):
		current.Update(delta)
	
	%Parent.global_rotation.y = lerp_angle(%Parent.global_rotation.y, atan2(dir.x, dir.y), delta * 10)

func _physics_process(delta):
	if current.has_method("Physics"):
		current.Physics(delta)


func _on_anim_animation_finished(anim_name):
	
	current = $IDLE
