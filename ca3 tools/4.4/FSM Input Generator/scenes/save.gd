extends Node

func _on_savebutton_pressed():
	%Save.show()

func _on_save_button_pressed():
	
	%Save.show()


func _on_save_dir_selected(path):
	
	var log = ""
	
	var movetmp = PackedScene.new()
	
	var move = movetmp.pack($"../../INPUT/FSM/Move")
	if move == OK:
		var error = ResourceSaver.save(movetmp, path + "/Move.tscn")
		if error != OK:
			log += "There was an error, couldn't save the move file" + "\n"
		else:
			log += "Move Saved sucesfully" + "\n"
	
	var buttontmp = PackedScene.new()
	
	var button = buttontmp.pack($"../../INPUT/FSM/Button")
	if button == OK:
		var error = ResourceSaver.save(buttontmp, path + "/Button.tscn")
		if error != OK:
			log += "There was an error, couldn't save the Button file" + "\n"
		else:
			log += "Button Saved sucesfully" + "\n"
	
	var specialtmp = PackedScene.new()
	
	var special = specialtmp.pack($"../../INPUT/FSM/Special")
	if move == OK:
		var error = ResourceSaver.save(specialtmp, path + "/Special.tscn")
		if error != OK:
			log += "There was an error, couldn't save the Special file" + "\n"
		else:
			log += "Special Saved sucesfully" + "\n"
	
	%Log.text = log
		
	
	
