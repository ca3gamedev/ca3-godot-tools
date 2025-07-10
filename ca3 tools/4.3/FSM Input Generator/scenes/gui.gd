extends Node

func _ready():
	%GameInfo.show()
	%TESTPanel.hide()


func _on_test_pressed():
	%GameInfo.hide()
	%TESTPanel.show()


func _on_edit_pressed():
	%GameInfo.show()
	%TESTPanel.hide()
