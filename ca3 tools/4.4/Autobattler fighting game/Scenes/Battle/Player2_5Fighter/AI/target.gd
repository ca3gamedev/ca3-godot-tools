extends Node

func _ready() -> void:
	$"../Kick".start(randf_range(0.5, 2))


enum goal_type {
	wait, chase, punch, keepaway, jump_f, jump_v, jump_b
}

var goal = goal_type.wait


func _on_kick_timeout() -> void:
	goal = goal_type.punch
	$"../Kick".start(randf_range(0.5, 2))
