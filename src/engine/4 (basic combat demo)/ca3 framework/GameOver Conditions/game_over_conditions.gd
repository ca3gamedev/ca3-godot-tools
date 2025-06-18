extends Node

@export var Next : String
@export var delay : bool

func _ready():
	$Timer.start(0.5)
	$LevelDelay.start(2)

func _on_timer_timeout():
	if not delay:
		return
	var enemies = get_tree().get_nodes_in_group("ENEMY").size()
	
	if VariableNodes.HP < 1 and delay:
		get_tree().change_scene_to_file(Next)
	if enemies < 1 and delay:
		Transitions.End()
		$"../".PAUSE()


func _on_level_delay_timeout():
	delay = true
