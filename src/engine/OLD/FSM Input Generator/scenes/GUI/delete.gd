extends Node

var button_id = 0
var skill_id = 0


func _on_deletebutton_pressed():
	var children = $"../../INPUT/FSM/Button".get_children()
	for i in len(children):
		if i == button_id:
			$"../../INPUT/FSM/Button".get_child(i).queue_free()
			%InputListButtons.remove_item(button_id)
			button_id = 0
	
func _on_input_list_buttons_item_selected(index):
	button_id = index


func _on_input_list_motions_item_selected(index):
	skill_id = index


func _on_deletemotions_pressed():
	var children = $"../../INPUT/FSM/Special".get_children()
	for i in len(children):
		if i == skill_id:
			$"../../INPUT/FSM/Special".get_child(i).queue_free()
			%InputListMotions.remove_item(i)
			skill_id = 0
