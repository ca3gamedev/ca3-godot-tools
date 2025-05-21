extends Node

@export var ismovement : bool = true

func Update(delta):
	#$"../".Anim.set("parameters/MOVE/blend_position",  $"../".Transition.motion * 0.5)
	pass
