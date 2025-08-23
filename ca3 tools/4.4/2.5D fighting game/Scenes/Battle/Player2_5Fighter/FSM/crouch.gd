extends Node

func Update(delta):
	
	if not Input.is_action_pressed("DOWN"):
		%FSM.current = %FSM.get_node("IDLE")
		%FSM.current.Start()


func Start():
	%FSM.state.travel("CROUCHED")
