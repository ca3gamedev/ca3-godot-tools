extends Node2D

@export var hitstun : float = 1.0
@export var shakestrenght : float = 10.0
@export var shake_speed : float = 2.0


func _on_hitbox_area_entered(area):
	
	if area.is_in_group("ENEMY"):
		%HitstopFreeze.start(hitstun)
		area.get_parent().HIT()
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		$"..".call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)


func _on_hitstop_freeze_timeout():
	$"..".call_deferred("set_process_mode", Node.PROCESS_MODE_INHERIT)
