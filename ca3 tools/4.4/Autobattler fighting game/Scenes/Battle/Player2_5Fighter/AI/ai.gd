extends Node

func _ready() -> void:
	if $"..".IsAI:
		$Update.start(0.3)

func _process(delta: float) -> void:
	
	if not %FSM.Root.IsAI:
		return
	
	var angle  = $"..".Player.global_position - $"..".global_position
	var dir = 0
	if angle.x < 0:
		dir = -1
	if angle.x > 0:
		dir = 1
	%FSM.raw_dir_ai.x = dir
	if $"..".IsAI:
		Log.PRINT(str(%Target.goal_type.keys().get(%Target.goal)) + "       " + %FSM.current.name)


func _on_update_timeout() -> void:
	$GetDistance.GetDistance()
	$MinMax.MinMax()
