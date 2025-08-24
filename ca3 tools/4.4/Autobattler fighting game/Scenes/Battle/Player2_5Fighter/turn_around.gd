extends Node

@export var time : float
@export var delay : bool

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
		%FSM.current = %FSM.get_node("IDLE")
		%FSM.current.Start()
		

func _on_delay_turn_ai_timeout() -> void:
	delay = false
