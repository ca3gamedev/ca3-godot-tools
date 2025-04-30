extends ColorRect

@export var fireball_spawn_point : Node2D

func _ready():
	self.global_position = fireball_spawn_point.global_position
