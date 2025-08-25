extends Node2D

func _ready() -> void:
	
	if Variables.LastLoser == Variables.LoserPick:
		$Label.text = "YOU GOT IT RIGHT!!!"
	else:
		$Label.text = "YOU GOT IT WRONG."


func _on_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/Menues/Choice/pick_girl.tscn")
