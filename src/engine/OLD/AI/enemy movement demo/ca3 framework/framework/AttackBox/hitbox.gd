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
		area.HIT()
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
	
	if area.is_in_group("ENEMY") and self.is_in_group("PLAYER"):
		area.HIT()
		ENEMYHIT()


func ENEMYHIT():
		%HitstopFreeze.start(hitstun)
		VariableNodes.ADDSCORE(1)
		VariableNodes.MyCamera2D.Shake(shakestrenght, shake_speed)
		get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
