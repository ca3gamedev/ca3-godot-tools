extends Node2D


func _on_hitbox_area_entered(area):
	
	if area.is_in_group("ENEMY"):
		area.get_parent().HIT()
