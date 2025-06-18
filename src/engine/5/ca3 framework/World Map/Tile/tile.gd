extends Node2D

@export var pos : Vector2i

@export var id : int

func DISABLE():
	$Tile.modulate = Color.SADDLE_BROWN
	$AnimatedSprite2D.modulate = Color.DARK_OLIVE_GREEN

func SetID(i):
	id = i
	$AnimatedSprite2D.frame = id
