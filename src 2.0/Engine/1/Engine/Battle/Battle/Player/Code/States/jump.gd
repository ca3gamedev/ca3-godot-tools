extends Node
var fsm: FSM

func _update(_delta):
	transition()

func transition():
	if $"../..".is_on_floor():
		fsm.change_state("idle")
