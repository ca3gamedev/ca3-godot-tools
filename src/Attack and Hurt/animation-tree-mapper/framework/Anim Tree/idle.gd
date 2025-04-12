extends Node

func UpdateAnim():
	$"../".Anim.set("parameters/MOVE/blend_position",  $"../".Transition.motion * 0.5)
