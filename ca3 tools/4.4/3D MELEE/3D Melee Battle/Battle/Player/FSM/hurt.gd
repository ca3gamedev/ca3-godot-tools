extends Node


func _on_hurtbox_area_entered(area):
	
	if area.is_in_group("ENEMY MELEE"):
		%FSM.state_machine.travel("HURT")

func Hitstop():
	%Hitstop.start(0.15)
	$"../..".process_mode = Node.PROCESS_MODE_DISABLED
