extends Node


func Update(delta):
	$"../".Anim.set("parameters/MOVE/blend_position",  %AIMotion.motion * 0.5)
