extends Button



func _on_pressed():
	%OptionsMenue.show()
	if is_instance_valid(VariableNodes.GUI):
		VariableNodes.GUI.HIDE()
