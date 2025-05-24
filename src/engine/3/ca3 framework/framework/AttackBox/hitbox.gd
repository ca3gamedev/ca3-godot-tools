extends Node2D

@export var is_AI : bool
@export var hitstun : float 
@export var shakestrenght : float 
@export var shake_speed : float 
@export var fireball_spawn : bool
@export var is_fireball : bool


func HIT():
	%Code.HIT()

func _on_anim_tree_animation_finished(anim_name):
	
	$AnimTree.set("parameters/conditions/attack", false)


func _on_area_entered(area):
	
	if self.is_in_group("ENEMY") and area.is_in_group("PLAYER"):
		# ENEMY HIT THE PLAYER
		area.HIT()
		VariableNodes.enemy_damage = $"../..".enemy_damage
		ENEMYHIT()
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
	
	if area.is_in_group("ENEMY") and self.is_in_group("PLAYER"):
		# THE PLAYER HIT ENEMIES
		area.HIT()
		%HitstopFreeze.start(hitstun)
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)


func ENEMYHIT():
		%HitstopFreeze.start(hitstun)
		VariableNodes.DAMAGE()
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
