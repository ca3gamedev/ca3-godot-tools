extends Node


func _on_save_pressed():
	%SaveScene.show()


func _on_save_scene_file_selected(path):
	var node = %Root.get_children()
	
	if not node.is_empty():
		var tmp = PackedScene.new()
		tmp.pack(%Root.get_child(0))
		ResourceSaver.save(tmp, path)
		%Log.text = "SCENE SAVED TO " + path
	else:
		%Log.text = "NO FILE TO SAVE"
