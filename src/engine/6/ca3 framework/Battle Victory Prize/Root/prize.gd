extends Node2D

@export var id : int

func _on_start_of_timer_timeout():
	$Update.start(0.1)


func _on_update_timeout():
	id += 1
	var chance = randi_range(-10, 10)
	$ProgressBar.value += sign(chance) * int (randi_range(1, 10) / 2)
	$LOG.text = "Loop " + str(id)
	
	if id >= 100:
		$LOG.text = "DECIDING..."
		$End.start(2)
		$Update.stop()


func _on_end_timeout():
	
	var coins = int($ProgressBar.value / 20)
	VariableNodes.coins = coins * 6
	$LOG.text = "YOU WIN ... " + str(coins)  + "  coins."
	$Change.start(2)


func _on_change_timeout():
	Music.STOPSONG()
	Transitions.Next = SceneDirectory.GetScreen("World Map")
	VariableNodes.battle_won = true
	Transitions.Start()
	
