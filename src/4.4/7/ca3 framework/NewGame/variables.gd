extends Node


func Save(CurrentFile):
	var file_name = "user://save_file" + str(CurrentFile) + ".json"
	var save_file = FileAccess.open(file_name, FileAccess.WRITE)
	if not save_file:
		print("Failed to open file for saving.")
		return

	var json_string = JSON.stringify(VariableNodes.Get_DATA(), "\t")
	save_file.store_string(json_string)
	save_file.close()

func LoadSave(file):
	var file_name = "user://save_file_" + str(file) + ".json"
	
	if not FileAccess.file_exists(file_name):
		print("Not save file")
		return
	
	var save_file = FileAccess.open(file_name, FileAccess.READ)
	var json_string = save_file.get_as_text()
	save_file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())
		return
	
	var loaded_data = json.data
	
	VariableNodes.LOAD_DATA(loaded_data)
	

func SaveEmpty(file):
	var file_name = "user://save_file" + str(file) + ".json"
	
	var save_file = FileAccess.open(file_name, FileAccess.WRITE)
	
	var json_string = JSON.stringify(VariableNodes.New_DATA(), "\t")
	save_file.store_line(json_string)

	save_file.close()




func CheckSaveExist(file):
	var file_name = "user://save_file" + str(file) + ".json"
	if not FileAccess.file_exists(file_name):
		return false
	return true
