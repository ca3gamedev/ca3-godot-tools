extends Node2D

@export var hitstun : float 
@export var shakestrenght : float 
@export var shake_speed : float 
@export var fireball_spawn : bool

func _ready():
	$AnimTree.active = true


func _on_hitbox_area_entered(area):
	
	if area.is_in_group("ENEMY"):
		%Code.HIT.call_deferred()
		%HitstopFreeze.start(hitstun)
		area.get_parent().HIT()
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
		Set_Disable.call_deferred(true)
	
	if area.is_in_group("PLAYER"):
		if area.GetID() != $"../".PlayerID:
			%Code.HIT.call_deferred()
			area.HIT(hitstun)
			%HitstopFreeze.start(hitstun)
			VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
			get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
			Set_Disable.call_deferred(true)

func Set_Disable(argument):
	$Hitbox/CollisionShape2D.disabled = argument

func _on_anim_tree_animation_finished(anim_name):
	
	$AnimTree.set("parameters/conditions/attack", false)
