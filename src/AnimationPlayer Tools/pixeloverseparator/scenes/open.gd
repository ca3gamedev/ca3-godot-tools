extends Node

var folder = ""

func _on_open_button_pressed():
	%Open.show()


func _on_open_dir_selected(dir):
	folder = dir
	
	$ProcessFolder.LOAD(folder)
