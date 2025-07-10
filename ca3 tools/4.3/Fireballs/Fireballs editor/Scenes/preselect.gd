extends Node

@export var pre_name : String
@export var distance : float = 1.0
@export var post_name : String

func _ready():
	%DistanceLOG.text = str(distance)

func _on_preselect_pressed():
	
	%LOGNAMES.clear()
	
	if %DirNumber.selected == 0:
		%LOGNAMES.add_item("sprites/" + pre_name + "_LEFT_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_RIGHT_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_FRONT_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_BACK_")
	else:
		%LOGNAMES.add_item("sprites/" + pre_name + "_LEFT_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_RIGHT_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_FRONT_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_BACK_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_FRONT_LEFT_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_FRONT_RIGHT_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_BACK_LEFT_")
		%LOGNAMES.add_item("sprites/" + pre_name + "_BACK_RIGHT_")



func _on_current_selected_name_text_changed(new_text):
	pre_name = new_text

func _on_current_selected_name_text_submitted(new_text):
	pre_name = new_text


func _on_change_pressed():
	
	if %DirNumber.selected == 0:
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_RIGHT_", Vector2(distance, 0))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_LEFT_", Vector2(-distance, 0))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_FRONT_", Vector2(0, distance))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_BACK_", Vector2(0, -distance))
	else:
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_RIGHT_", Vector2(distance, 0))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_LEFT_", Vector2(-distance, 0))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_FRONT_", Vector2(0, distance))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_BACK_", Vector2(0, -distance))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_BACK_LEFT_", Vector2(-distance, -distance))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_BACK_RIGHT_", Vector2(distance, -distance))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_FRONT_LEFT_", Vector2(-distance, distance))
		%LoadParams.ChangeAnim("sprites/" + pre_name + "_FRONT_RIGHT_", Vector2(distance, distance))
	
	%LoadParams.LOADNODE()

func _on_distance_text_changed(new_text):
	distance = float(new_text)

func _on_distance_text_submitted(new_text):
	distance = float(new_text)
	%DistanceLOG.text = str(distance)


func _on_current_change_name_text_changed(new_text):
	post_name = new_text


func _on_current_change_name_text_submitted(new_text):
	post_name = new_text


func _on_add_new_pressed():
	
	if %DirNumber.selected == 0:
		%LoadParams.AddAnim("sprites/" + pre_name + "_RIGHT_", Vector2(distance, 0))
		%LoadParams.AddAnim("sprites/" + pre_name + "_LEFT_", Vector2(-distance, 0))
		%LoadParams.AddAnim("sprites/" + pre_name + "_FRONT_", Vector2(0, distance))
		%LoadParams.AddAnim("sprites/" + pre_name + "_BACK_", Vector2(0, -distance))
	else:
		%LoadParams.AddAnim("sprites/" + pre_name + "_RIGHT_", Vector2(distance, 0))
		%LoadParams.AddAnim("sprites/" + pre_name + "_LEFT_", Vector2(-distance, 0))
		%LoadParams.AddAnim("sprites/" + pre_name + "_FRONT_", Vector2(0, distance))
		%LoadParams.AddAnim("sprites/" + pre_name + "_BACK_", Vector2(0, -distance))
		%LoadParams.AddAnim("sprites/" + pre_name + "_BACK_LEFT_", Vector2(-distance, -distance))
		%LoadParams.AddAnim("sprites/" + pre_name + "_BACK_RIGHT_", Vector2(distance, -distance))
		%LoadParams.AddAnim("sprites/" + pre_name + "_FRONT_LEFT_", Vector2(-distance, distance))
		%LoadParams.AddAnim("sprites/" + pre_name + "_FRONT_RIGHT_", Vector2(distance, distance))
	
	%LoadParams.LOADNODE()


func _on_delete_pressed():
	if %DirNumber.selected == 0:
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_RIGHT_", Vector2(distance, 0))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_LEFT_", Vector2(-distance, 0))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_FRONT_", Vector2(0, distance))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_BACK_", Vector2(0, -distance))
	else:
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_RIGHT_", Vector2(distance, 0))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_LEFT_", Vector2(-distance, 0))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_FRONT_", Vector2(0, distance))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_BACK_", Vector2(0, -distance))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_BACK_LEFT_", Vector2(-distance, -distance))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_BACK_RIGHT_", Vector2(distance, -distance))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_FRONT_LEFT_", Vector2(-distance, distance))
		%LoadParams.DeleteAnim("sprites/" + pre_name + "_FRONT_RIGHT_", Vector2(distance, distance))
	
	%LoadParams.LOADNODE()
