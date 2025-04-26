extends Node

@export var cancel : bool
@export var attackstrenght : int = -999
@export var dashcancel : bool = false
@export var walkcancel : bool = false

func UpdateAnim():
	$"../".Anim.set("parameters/MOVE/blend_position", $"../".Transition.motion)
