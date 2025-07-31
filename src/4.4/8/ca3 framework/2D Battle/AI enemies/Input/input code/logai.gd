extends Node

@export var Melee_dist : Color
@export var LongMelee_dist : Color
@export var Mid_dist : Color
@export var Long_dist : Color
@export var Far_dist : Color

@export var rect_log : ColorRect

func LOG():
	
	if $"../../".IsAutobattler:
		if $"../../".TeamID == 0:
			rect_log.color = Color.BLUE
		if $"../../".TeamID == 1:
			rect_log.color = Color.RED
	else:	
		var distance_type = %DecisionOutput.tier
		match(distance_type):
			0 : rect_log.color = Melee_dist
			1 : rect_log.color = LongMelee_dist
			2 : rect_log.color = Mid_dist
			3 : rect_log.color = Long_dist
			4 : rect_log.color = Far_dist
