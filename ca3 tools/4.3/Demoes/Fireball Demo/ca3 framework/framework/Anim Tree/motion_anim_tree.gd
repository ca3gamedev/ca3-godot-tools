extends Node

@export var Anim : AnimationTree
@export var Transition : Node

func _ready():
	Anim = %AnimTree.get_node("Anim")
