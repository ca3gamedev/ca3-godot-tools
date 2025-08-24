extends Node

func Start(attack):
	match (attack):
		"KICK" : %FSM.state.travel("KICK")
		"HURT" : %FSM.state.start("JUMP_HURT", true)
		"AIR HURT" : %FSM.state.start("Jump F", true)
