extends Node

@export var distance : float

enum distance_type {
	touching, melee, middle, long
}

var current_distance = distance_type.long

func GetDistance():
	distance = $"../..".Oponent.global_position.distance_to($"../..".global_position)
	
	if distance < 3.0:
		current_distance = distance_type.touching
	elif distance > 3.0 and distance < 5.0:
		current_distance = distance_type.melee
	elif distance > 5.0 and distance < 10.0:
		current_distance = distance_type.middle
	else:
		current_distance = distance_type.long
