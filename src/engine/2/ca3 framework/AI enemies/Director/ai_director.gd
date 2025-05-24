extends Node2D

@export var spawn_number_enemy : int
@export var enemy01 : PackedScene

func _ready():
	for i in spawn_number_enemy:
		Spawn()


func Spawn():
	var x = randf_range($TOPLEFT.global_position.x, $BOTTOMRIGHT.global_position.x)
	var y = randf_range($TOPLEFT.global_position.y, $BOTTOMRIGHT.global_position.y)
	var tmp = enemy01.instantiate()
	tmp.global_position = Vector2(x, y)
	$Enemies.add_child(tmp)
