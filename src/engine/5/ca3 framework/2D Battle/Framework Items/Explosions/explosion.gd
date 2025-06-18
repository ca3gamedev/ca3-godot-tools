extends Area2D

@export var damage : int
@export var is_fireball : bool

func _on_area_entered(area):
	
	if area.is_in_group("ENEMY"):
		VariableNodes.AddComboKill()
		Music.Slash() 
		area.get_node("../").DAMAGE(damage)


func _on_animation_player_animation_finished(anim_name):
	self.queue_free()
