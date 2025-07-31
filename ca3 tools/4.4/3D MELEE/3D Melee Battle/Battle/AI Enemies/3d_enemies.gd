extends CharacterBody3D

var target : Vector2
@export var distance : float
@export var wavy : bool
@export var wavy_amplitude : float


func _ready():
	%Anim.active = true

func ChangeShadow(i):
	var material = $Shadow.material_override
	material.albedo_color = Color8(255/(i+1), 0, 0, 255)
