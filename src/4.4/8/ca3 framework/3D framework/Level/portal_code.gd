extends Node

@export var Next : String

func _on_portal_body_entered(body):
	
	if body.is_in_group("PLAYER"):
		Transitions.Next = SceneDirectory.GetScreen($"../".Next)
		VariableNodes.battle_won = true
		Transitions.Start()
		Frame.ShowCRT()
