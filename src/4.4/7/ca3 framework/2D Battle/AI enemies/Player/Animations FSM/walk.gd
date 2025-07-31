extends Node

func Update(delta):
	if not $"../../".IsAI:
		$"../".Anim.set("parameters/MOVE/blend_position", %AIMotion.motion)
	pass
