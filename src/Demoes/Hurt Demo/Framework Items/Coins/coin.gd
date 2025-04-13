extends Node2D

@export var respawn_dead : bool

func HIT():
	if respawn_dead:
		get_parent().Spawn()
	self.queue_free()
