extends Node

func _on_savebutton_pressed():
	%Save.show()


func _on_save_file_selected(path):
	
	var tmp = PackedScene.new()
	
	var tmpacked = tmp.pack($"../../INPUT")
	if tmpacked == OK:
		var error = ResourceSaver.save(tmp, path)
		if error != OK:
			%Log.text = "There was an error, couldn't save the input file"
		else:
			%Log.text = "Saved sucesfully"
