extends Area2D

@export var is_fireball : bool

func GetDAMAGE():
	return $"..".damage


func HIT():
	$"../".queue_free()
