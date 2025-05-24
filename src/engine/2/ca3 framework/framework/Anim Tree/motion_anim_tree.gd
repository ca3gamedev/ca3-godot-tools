extends Node

@export var Anim : AnimationTree
@export var Transition : Node

func _ready():
	await get_tree().process_frame
	Anim = $"../".Sprites.get_node("Anim")
