extends Button

@export var Next : String


func _on_pressed():
	get_tree().change_scene_to_file(Next)
	
