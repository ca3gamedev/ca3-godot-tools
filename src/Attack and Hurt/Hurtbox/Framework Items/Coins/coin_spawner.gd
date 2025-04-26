extends Node2D

@export var coin : PackedScene

func Spawn():
	var tmp = coin.instantiate()
	var x = randf_range($TOPLEFT.global_position.x, $BOTTOMRIGHT.global_position.x)
	var y = randf_range($TOPLEFT.global_position.y, $BOTTOMRIGHT.global_position.y)
	tmp.global_position = Vector2(x, y)
	add_child.call_deferred(tmp)
