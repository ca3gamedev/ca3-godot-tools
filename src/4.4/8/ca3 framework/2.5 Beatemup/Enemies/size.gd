extends Node

@export var myorigin : Node2D
@export var min_size : float
@export var max_size : float
@export var Sprite : AnimatedSprite2D

func _ready():
	myorigin = VariableNodes.MyCamera2D.get_node("origin")

func _process(delta):
	
	var pos = myorigin.to_local(Sprite.global_position)
	var y = (pos.y / 1000) * 1.5
	var c_y = clampf(y, min_size, max_size)
	Sprite.scale = Vector2(c_y, c_y)
