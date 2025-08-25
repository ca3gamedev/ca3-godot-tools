extends Node

@export var distance : float

enum distance_type {
	touching, melee, middle, long
}

var current_distance = distance_type.long

func GetDistance():
	
	if not %FSM.Root.IsAI:
		return
		
	distance = $"../..".Player.global_position.distance_to($"../..".global_position)
	
	if distance < 3.0:
		current_distance = distance_type.touching
	elif distance > 3.0 and distance < 5.0:
		current_distance = distance_type.melee
	elif distance > 5.0 and distance < 10.0:
		current_distance = distance_type.middle
	else:
		current_distance = distance_type.long


func GetClosestAI():
	var minimal = 99999999999
	var closest = %FSM.Root.Oponent[0]
	for i in %FSM.Root.Oponent:
		var dist = i.global_position.distance_to(%FSM.Root.global_position)
		if dist < minimal and i.name != %FSM.Root.name:
			closest = i
			minimal = dist
	%FSM.Root.Closest = closest


func _on_get_closest_timeout() -> void:
	GetClosestAI()
