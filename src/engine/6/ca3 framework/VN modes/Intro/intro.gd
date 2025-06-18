extends Node2D

@export var idle : bool


func _on_timer_timeout():
	idle = true


func _process(delta):
	
	if idle:
		if Input.is_action_just_released("A"):
			Transitions.Next = SceneDirectory.GetScreen("World Map")
			VariableNodes.battle_won = true
			Transitions.Start()
