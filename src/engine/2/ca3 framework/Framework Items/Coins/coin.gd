extends Node2D

@export var respawn_dead : bool
@export var shakestrenght : float
@export var shake_speed : float

func HIT():
	if respawn_dead:
		get_parent().Spawn()
	self.queue_free()


func _on_coin_hitbox_area_entered(area):
	
	if area.is_in_group("FIREBALL"):
		HIT()
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		area.get_parent().queue_free()
