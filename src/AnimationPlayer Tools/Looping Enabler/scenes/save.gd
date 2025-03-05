extends Node



func _on_save_file_selected(path):
	
	var animatedsprite = PackedScene.new()
	var animatedspritepacked = animatedsprite.pack(%ANIM.get_child(0))
	
	if animatedspritepacked == OK:
		var error = ResourceSaver.save(animatedsprite, path)
		if error != OK:
			%Log.text = "There was an error, couldn't save the animated player scene file"
		else:
			%Log.text = "Saved animation player scene sucesfully"


func _on_button_pressed():
	%Save.show()
