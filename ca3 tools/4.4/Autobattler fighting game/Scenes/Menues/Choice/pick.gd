extends Button

@export var loserpick : int

func _on_pressed() -> void:
	Variables.LoserPick = loserpick
	get_tree().change_scene_to_file("res://Scenes/Battle/Root 25 fighter/root.tscn")
