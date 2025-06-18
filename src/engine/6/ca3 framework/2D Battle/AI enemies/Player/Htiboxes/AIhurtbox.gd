extends Area2D

@export var Transition : Node
@export var is_fireball : bool

func HIT():
	%Code.HIT()


func _on_area_entered(area):
	
	if not area.is_fireball and self.is_in_group("ENEMY") and area.is_in_group("FIREBALL"):
		%HitstopFreeze.start(0.2)
		Music.Slash()
		$"..".DAMAGE(area.GetDAMAGE())
		self.HIT()
		VariableNodes.MyCamera2D.Shake(%Hitbox.shakestrenght, %Hitbox.shake_speed)
		$"../".call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
		area.get_parent().queue_free()
	
	if not $"../".IsHealer and area.is_in_group("ENEMY_HEALING"):
		%HitstopFreeze.start(0.2)
		Music.Slash()
		$"..".HEAL()
		self.HIT()
		VariableNodes.MyCamera2D.Shake(%Hitbox.shakestrenght, %Hitbox.shake_speed)
		$"../".call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
		area.get_parent().queue_free()
