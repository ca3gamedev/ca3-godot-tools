extends Node


func _on_save_pressed():
	
	%SaveJSON.show()


func _on_save_json_file_selected(path):
	SAVE(path)


func SAVE(path):
	
	var data = []
	data.append("HURTBOX POS")
	data.append(%Data.hurtbox_pos)
	data.append("HURTBOX SIZE")
	data.append(%Data.hurtbox_size)
	data.append("HITBOX POS")
	data.append(%Data.hitbox_pos)
	data.append("HITBOX SIZE")
	data.append(%Data.hitbox_size)
	data.append("FIREBALL POS")
	data.append(%Data.fireball_pos)
	
	var json_string = JSON.stringify(data, "\t")

	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
		print("Data saved to", path)
	else:
		push_error("Failed to open file for writing.")
