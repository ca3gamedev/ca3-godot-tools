extends Node
class_name InputBuffer

@export var buffer_time := 0.3

# Each entry is a dictionary: { action = String, time_left = float }
var buffer: Array = []

func _process(delta: float) -> void:
	var i := buffer.size() - 1
	while i >= 0:
		buffer[i].time_left -= delta
		if buffer[i].time_left <= 0:
			buffer.remove_at(i)
		i -= 1

func buffer_input(action: String) -> void:
	buffer.append({
		"action": action,
		"time_left": buffer_time
	})

func consume_input(target_action: String) -> bool:
	var i := buffer.size() - 1
	while i >= 0:
		if buffer[i].action == target_action:
			buffer.remove_at(i)
			return true
		i -= 1
	return false

func is_action_buffered(target_action: String) -> bool:
	for entry in buffer:
		if entry.action == target_action:
			return true
	return false
