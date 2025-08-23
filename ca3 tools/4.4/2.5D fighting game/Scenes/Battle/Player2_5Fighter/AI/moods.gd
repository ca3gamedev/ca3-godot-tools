extends Node

enum mood {
	agressive, keepaway, idle
}

var current_mood = mood.keepaway

func _ready() -> void:
	$"../Agressive".start(randf_range(1, 3))
	$"../Defensive".start(randf_range(1, 3))
	
func _on_agressive_timeout() -> void:
	current_mood = mood.agressive
	$"../Agressive".start(randf_range(1, 5))


func _on_defensive_timeout() -> void:
	current_mood =  mood.keepaway
	$"../Defensive".start(randf_range(1, 5))


func _on_idle_timeout() -> void:
	current_mood = mood.idle
