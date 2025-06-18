extends Node

@export var ismovement : bool = true

func Update(delta):
	if $"../".Anim != null:
		$"../".Anim.set("parameters/MOVE/blend_position", $"../".Transition.motion)
	pass
