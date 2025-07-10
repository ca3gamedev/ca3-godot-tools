extends Node


func _on_save_pressed():
	%SaveDialog.show()


func _on_save_dialog_file_selected(path):
	
	var tmp = PackedScene.new()
	tmp.pack($"../../Character/Player")
	ResourceSaver.save(tmp, path)
	%LOG.text = "SCENE SAVED TO " + path
	
