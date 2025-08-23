extends Node

var cooldown : bool

func _ready() -> void:
	if $"..".IsAI:
		$Update.start(0.3)

func _process(delta: float) -> void:
	var angle = $"..".Oponent.global_position - $"..".global_position
	var dir = 0
	if angle.x < 0:
		dir = -1
	if angle.x > 0:
		dir = 1
	%FSM.raw_dir_ai.x = dir


func _on_update_timeout() -> void:
	$GetDistance.GetDistance()
	$MinMax.MinMax()
