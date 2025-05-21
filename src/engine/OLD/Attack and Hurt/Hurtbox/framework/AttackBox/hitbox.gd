extends Node2D

@export var hitstun : float = 1.0
@export var shakestrenght : float = 10.0
@export var shake_speed : float = 2.0

func _ready():
	$AnimTree.active = true


func _on_hitbox_area_entered(area):
	
	if area.is_in_group("ENEMY"):
		%HitstopFreeze.start(hitstun)
		area.get_parent().HIT()
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
	
	if area.is_in_group("PLAYER"):
		if area.GetID() != $"../".PlayerID:
			area.HIT(hitstun)
			%HitstopFreeze.start(hitstun)
			VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
			get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)

	


func _on_anim_tree_animation_finished(anim_name):
	
	$AnimTree.set("parameters/conditions/attack", false)
