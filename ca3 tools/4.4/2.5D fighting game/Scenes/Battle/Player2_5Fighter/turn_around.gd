extends Node

@export var time : float

func Update(delta):
	%FSM.state.travel("WALKING")


func _on_turn_around_timer_timeout() -> void:
	
	if not %FSM.Root.IsAI:
		if %FSM.raw_dir.x == 0:
			%FSM.current = %FSM.get_node("IDLE")
		else:
			%FSM.current = %FSM.get_node("WALK")
		%FSM.current.Start()
	else:
		%FSM.dir.x = %FSM.raw_dir.x
		if %FSM.raw_dir_ai.x == 0:
			%FSM.current = %FSM.get_node("IDLE")
		else:
			if %GetDistance.current_distance > %GetDistance.distance_type.melee:
				%FSM.current = %FSM.get_node("WALK")
			else:
				%FSM.current = %FSM.get_node("IDLE")
		%FSM.current.Start()
