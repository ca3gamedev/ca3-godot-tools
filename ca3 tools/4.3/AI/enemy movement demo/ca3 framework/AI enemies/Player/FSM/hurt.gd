extends Node

@export var attack_id : float

func Start():
	%Anim.set("parameters/conditions/Hurt", true)
	var dir = %AIMotion.player_angle
	%Anim.set("parameters/ATTACK/blend_position", attack_id * dir)
	
func Update(delta):
	pass
