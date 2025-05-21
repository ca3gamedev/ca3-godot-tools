extends FileDialog


func _on_file_selected(path):
	
	var tmp = PackedScene.new()
	tmp.pack(%Hurtbox)
	ResourceSaver.save(tmp, path)
	%LOG.text = "SCENE SAVED TO " + path
	
	


func _on_save_pressed():
	self.show()
