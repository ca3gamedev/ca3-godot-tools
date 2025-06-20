extends Node2D


var current = "top"

var country_selected = -9


func _ready():
	Clear()

func Clear():
	
	if VariableNodes.Countries_finished[0]:
		$State1Red.show()
		$State1Red.modulate = Color.SADDLE_BROWN
	else:
		$State1Red.hide()
	if VariableNodes.Countries_finished[1]:
		$State2Red.show()
		$State2Red.modulate = Color.SADDLE_BROWN
	else:
		$State2Red.hide()
	if VariableNodes.Countries_finished[2]:
		$State3Red.show()
		$State3Red.modulate = Color.SADDLE_BROWN
	else:
		$State3Red.hide()
	if VariableNodes.Countries_finished[3]:
		$State4Red.show()
		$State4Red.modulate = Color.SADDLE_BROWN
	else:
		$State4Red.hide()
	
	match(current):
		"top" : 
			$State2Red.modulate = Color.WHITE
			$State2Red.show()
		"left" : 
			$State1Red.modulate = Color.WHITE
			$State1Red.show()
		"right" : 
			$State4Red.modulate = Color.WHITE
			$State4Red.show()
		"down" : 
			$State3Red.modulate = Color.WHITE
			$State3Red.show()

func _process(delta):
	
	if Input.is_action_just_released("LEFT"):
		current = "left"
		country_selected = 0
		Clear()
	if Input.is_action_just_released("RIGHT"):
		current = "right"
		country_selected = 3
		Clear()
	if Input.is_action_just_released("DOWN"):
		current = "down"
		country_selected = 2
		Clear()
	if Input.is_action_just_released("UP"):
		current = "top"
		country_selected = 1
		Clear()
		
	if Input.is_action_just_released("A") and country_selected != -9:
		VariableNodes.country = current + "  NATION"
		VariableNodes.Countries_selected = country_selected
		Transitions.Next = SceneDirectory.GetNextLevel("Home")
		Transitions.Start()
	
	if Input.is_action_just_released("B"):
		Transitions.Next = SceneDirectory.GetScreen("Gallery")
		Transitions.Start()


func _on_game_over_timeout():
	
	if VariableNodes.Countries_finished[1]:
		if VariableNodes.Countries_finished[0]:
			if VariableNodes.Countries_finished[3]:
				if VariableNodes.Countries_finished[2]:
					Transitions.Next = SceneDirectory.GetScreen("Ending")
					Transitions.Start()
