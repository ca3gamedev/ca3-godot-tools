extends Node


func _on_file_dialog_dir_selected(dir):
	
	## This loads the folder names into the folder preview tab
	$AppCode.folder = dir
	$AppCode.savefolder = dir
	$AppCode.MakeAnimatedSprite()


func _on_open_pressed():
	%OpenDialog.show()


func _on_set_savefolder_pressed():
	%SaveFolder.show()


func _on_save_folder_dir_selected(dir):
	$AppCode.savefolder = dir


func _on_saveanimationplayer_pressed():
	## This creates a new packed scene from the AnimationPlayer parent node
	## And then saves the files 
	var animatedsprite = PackedScene.new()
	# I don't want to use % as nodepath because I don't want to generate any information on the
	# exported scene
	for c in $"../Panel/Pictures/AnimationPlayerPreview/Sprites".get_children():
		if not c.name == "Code":
			c.set_owner($"../Panel/Pictures/AnimationPlayerPreview/Sprites")
	var animatedspritepacked = animatedsprite.pack($"../Panel/Pictures/AnimationPlayerPreview/Sprites")
	if animatedspritepacked == OK:
		
		#This is where the file is saved with that custom name
		
		var error = ResourceSaver.save(animatedsprite, $AppCode.savefolder + "/" + "AnimationPlayerSprite.tscn")
		if error != OK:
			%Log.text = "There was an error, couldn't save the animated player scene file"
		else:
			%Log.text = "Saved animation player scene sucesfully"
