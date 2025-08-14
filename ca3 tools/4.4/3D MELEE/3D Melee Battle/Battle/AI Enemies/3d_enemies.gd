extends CharacterBody3D

var target : Vector2
@export var wavy : bool
@export var wavy_amplitude : float
@export var idle_distance : float

var npc_target_dir : Vector2

func _ready():
	%Anim.active = true

func ChangeShadow(i):
	var material = $Shadow.material_override
	material.albedo_color = Color8(255/(i+1), 0, 0, 255)


func _on_hitstop_timeout():
	self.process_mode = Node.PROCESS_MODE_INHERIT
