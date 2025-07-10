extends Node

func _process(delta):
	if %Player.HP < 1 :
		Transitions.Next = SceneDirectory.GetScreen("Game Over")
		Transitions.Start()
	
	if %Enemy.HP < 1 :
		Transitions.Next = SceneDirectory.GetScreen("World Map")
		VariableNodes.battle_won = true
		Transitions.Start()
