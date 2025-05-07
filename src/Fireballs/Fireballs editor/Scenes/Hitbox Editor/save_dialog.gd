extends FileDialog


func _on_file_selected(path):
	
	var tmp = PackedScene.new()
	tmp.pack(%Hitbox)
	ResourceSaver.save(tmp, path + "/Hitbox_scene.tscn")
	var tmp2 = PackedScene.new()
	tmp2.pack(%Hurtbox)
	ResourceSaver.save(tmp2, path + "/Hurtbox_scene.tscn")
	
	%LOG.text = "SCENE SAVED TO " + path
	
	


func _on_save_pressed():
	self.show()


func _on_dir_selected(dir):
	
	var tmp = PackedScene.new()
	tmp.pack(%Hitbox)
	ResourceSaver.save(tmp, dir + "/Hitbox_data.tscn")
	var tmp2 = PackedScene.new()
	tmp2.pack(%Hurtbox)
	ResourceSaver.save(tmp2, dir + "/Hurtbox_data.tscn")
	
	%LOG.text = "SCENE SAVED TO " + dir
	
