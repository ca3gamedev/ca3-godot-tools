extends Node2D

var Combo : int = 0
var HP = []

var Winner = 0

func _ready() -> void:
	
	Variables.GUI = self
	
	var Oponent = get_tree().get_nodes_in_group("ENEMY")
	for i in Oponent.size():
		HP.append(100)
		Oponent[i].ID = i
		Oponent[i].get_node("IDLabel").text = "ID : " + str(i)
		match(i):
			0 : Oponent[i].get_node("IDLabel").modulate = Color.WHITE
			1 : Oponent[i].get_node("IDLabel").modulate = Color.BLUE
			2 : Oponent[i].get_node("IDLabel").modulate = Color.RED
			3 : Oponent[i].get_node("IDLabel").modulate = Color.WEB_GREEN
	%LifebarP1.get("theme_override_styles/fill").bg_color = Color.WHITE
	%LifebarP2.get("theme_override_styles/fill").bg_color = Color.BLUE
	%LifebarP3.get("theme_override_styles/fill").bg_color = Color.RED
	%LifebarP4.get("theme_override_styles/fill").bg_color = Color.WEB_GREEN
	ResetHP()
	
	%Gamble.text = "GAMBLE " + str(Variables.LoserPick)
	match(Variables.LoserPick):
		0: %Gamble.modulate = Color.WHITE
		1: %Gamble.modulate = Color.BLUE
		2: %Gamble.modulate = Color.RED
		3: %Gamble.modulate = Color.WEB_GREEN

func ResetHP():
	
	for i in HP.size():
		HP[i] = 100
	%LifebarP1.value = HP[0]
	%LifebarP2.value = HP[1]
	%LifebarP3.value = HP[2]
	%LifebarP4.value = HP[3]


func Hit(damage, target):
	HP[target] -= damage
	match(target):
		0 : %LifebarP1.value = HP[0]
		1 : %LifebarP2.value = HP[1]
		2 : %LifebarP3.value = HP[2]
		3 : %LifebarP4.value = HP[3]
	if HP[target] <= 0:
		Variables.LastLoser = target
		ResetScene.call_deferred()

func ResetScene():
	get_tree().change_scene_to_file("res://Scenes/Menues/BattleEnd/battle_end.tscn")
