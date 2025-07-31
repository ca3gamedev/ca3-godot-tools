extends Node2D

@export var respawn_dead : bool
@export var shakestrenght : float
@export var shake_speed : float

@export var explosion_scene : PackedScene

func HIT():
	self.queue_free()


func _on_coin_hitbox_area_entered(area):
	
	if area.is_in_group("FIREBALL"):
		AddExplosion.call_deferred()
		await get_tree().process_frame
		HIT()
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		if area != null:
			area.get_parent().queue_free()
		self.queue_free()

func AddExplosion():
	var tmp = explosion_scene.instantiate()
	tmp.global_position = self.global_position
	get_parent().add_child(tmp)
