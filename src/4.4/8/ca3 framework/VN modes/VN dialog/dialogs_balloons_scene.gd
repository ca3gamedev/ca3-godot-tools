extends Node2D

@export var target : float

func _process(delta):
	
	$Camera2D.position.y = lerp($Camera2D.position.y, target + 60, delta * 2)
