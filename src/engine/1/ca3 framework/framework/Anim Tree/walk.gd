extends Node

@export var ismovement : bool = true
@onready var fireballlinearangle = Vector2i.ZERO

func Update(delta):
	#$"../".Anim.set("parameters/MOVE/blend_position", $"../".Transition.motion)
	pass
