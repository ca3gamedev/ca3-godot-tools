extends Node

@export var ismovement : bool = true

func Update(delta):
	if $"../".Anim != null:
		$"../".Anim.set("parameters/MOVE/blend_position",  $"../".Transition.motion * 0.5)
	else:
		$"../".Anim = $"../../".Sprites.get_node("Anim")
	pass
