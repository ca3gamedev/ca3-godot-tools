extends Node

@export var hurt_id : float = 0.1

func UpdateAnim():
	pass

func Start():
	%Anim.set("parameters/conditions/Hurt", true)
	%Anim.set("parameters/HURT/blend_position", hurt_id * %Transitions.motion)
	$"../../../Sprites".get_node("%Animations").seek(0.0, true)
