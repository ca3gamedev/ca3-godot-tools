extends Node2D

func _ready():
	VariableNodes.PlayerBulletManager = self

func SpawnLinear(playerorigin : Vector2i , fireball, speed, angle, offset : Vector2i):
	var tmp = fireball.instantiate()
	tmp.angle = angle
	tmp.speed = speed
	tmp.global_position = playerorigin + offset
	add_child(tmp)
