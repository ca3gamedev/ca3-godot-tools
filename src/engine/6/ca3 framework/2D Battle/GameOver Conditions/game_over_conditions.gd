extends Node

@export var delay : bool

func _ready():
	$Timer.start(0.5)
	$LevelDelay.start(2)

func _on_timer_timeout():
	if not delay:
		return
	var enemies = get_tree().get_nodes_in_group("ENEMY").size()
	
	if VariableNodes.HP < 1 and delay:
		#VariableNodes.GameOver()
		pass
		
	if enemies < 1 and delay:
		Music.STOPSONG()
		Transitions.Next = SceneDirectory.GetScreen("World Map")
		VariableNodes.battle_won = true
		Transitions.Start()
		$"../".PAUSE()


func _on_level_delay_timeout():
	delay = true
