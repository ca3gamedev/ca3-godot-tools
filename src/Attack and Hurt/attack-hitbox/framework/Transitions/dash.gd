extends Node

func Update():
	if $"../".IsIdleDash():
		$"../".ChangeMotion("IDLE")
