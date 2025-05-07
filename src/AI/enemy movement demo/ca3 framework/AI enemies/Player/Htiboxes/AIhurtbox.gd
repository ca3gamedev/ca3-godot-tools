extends Area2D

@export var Transition : Node
@export var is_fireball : bool

func HIT():
	%Code.HIT()


func _on_area_entered(area):
	
	if not area.is_fireball and self.is_in_group("ENEMY") and area.is_in_group("FIREBALL"):
		VariableNodes.ADDSCORE(10)
		%HitstopFreeze.start(0.2)
		self.HIT()
		VariableNodes.MyCamera2D.Shake(%Hitbox.shakestrenght, %Hitbox.shake_speed)
		$"../".call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
		area.get_parent().queue_free()
