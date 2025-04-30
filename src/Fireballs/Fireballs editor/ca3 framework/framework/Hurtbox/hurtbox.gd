extends Area2D

@export var Transition : Node

func HIT(hitstun):
	Transition.ChangeMotion("WEAK HURT", -999)

func GetID():
	return $"../".PlayerID


func _on_area_entered(area):
	
	if area.is_in_group("FIREBALL"):
		if area.get_parent().PlayerID != $"..".PlayerID:
			%Code.HIT.call_deferred()
			%HitstopFreeze.start(%Hitbox.hitstun)
			VariableNodes.MyCamera2D.Shake(%Hitbox.shakestrenght, %Hitbox.shake_speed)
			get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
			%Hitbox.Set_Disable.call_deferred(true)
			area.get_parent().queue_free()
