extends Node

@export var pre_name : String = ""

func _on_current_selected_name_text_submitted(new_text):
	pre_name = new_text


func _on_current_selected_name_text_changed(new_text):
	pre_name = new_text


func _on_preselect_pressed():
	if pre_name == "":
		%LOG.text = "Preselect a non empty name"
		return
	%PreselectLOG.text = "sprites/" + pre_name + "_FRONT_"
