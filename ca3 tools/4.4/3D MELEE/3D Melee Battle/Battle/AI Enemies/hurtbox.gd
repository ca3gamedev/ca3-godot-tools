extends Node


func _on_bodybox_area_entered(area):
	
	if area.is_in_group("PLAYER MELEE"):
		%FSM.state_machine.travel("HURT")

func Hitstop():
	%Hitstop.start(0.15)
	$"../..".process_mode = Node.PROCESS_MODE_DISABLED
