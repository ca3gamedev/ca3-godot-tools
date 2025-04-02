extends Node

var type = 0
var root_name = "TEST"

func _ready():
	%FolderName.text = root_name

func _on_type_option_item_selected(index):
	type = index


func _on_folder_name_text_changed(new_text):
	if new_text.is_valid_identifier():
		root_name = new_text


func _on_folder_name_text_submitted(new_text):
	%FolderName.text = root_name


func _on_folder_name_focus_exited():
	%FolderName.text = root_name


func _on_sort_pressed():
	match(type):
		0 : Sort("none")
		1 : Sort("4dir")
		2 : Sort("8dir")
		3 : SortMugenNames()

func Sort(new_name):
	
	var dir = DirAccess.open(%ProcessFolder.dir_path)
	
	if DirAccess.dir_exists_absolute(%ProcessFolder.dir_path):
		for i in dir.get_directories():
			SortByNumber(new_name, %ProcessFolder.dir_path + "/" + i, i)

func SortByNumber(new_name, dir_path, folder_name):
	%Log.text = "Trying to process : " + str(folder_name)
	if DirAccess.open(dir_path):
		var folder = DirAccess.open(dir_path)
		var parent = DirAccess.open(%ProcessFolder.dir_path)
		var angle = 0
		if folder:
			DirAccess.make_dir_absolute(parent.get_current_dir() + "/" + root_name)
			var anim_folder = DirAccess.open(parent.get_current_dir() + "/" + root_name)
			var target_folder = DirAccess.open(parent.get_current_dir() + "/" + root_name)
			for file in folder.get_files():
				var filename = file
				var dir_pos = filename.find("_dir")
				if dir_pos != -1:
					var start_pos = dir_pos + 4
					var extracted_number = int(filename.substr(start_pos, 1))
					if extracted_number > angle:
						match(new_name):
							"none" : 
								var path = parent.get_current_dir() + "/" + root_name + "/" + folder_name + "_dir" + str(extracted_number)
								DirAccess.make_dir_absolute(path)
								target_folder = DirAccess.open(path)
							"4dir" : 
								var path = parent.get_current_dir() + "/" + root_name + "/" + folder_name + Get4DirName(extracted_number)
								DirAccess.make_dir_absolute(path)
								target_folder = DirAccess.open(path)
							"8dir" : 
								var path = parent.get_current_dir() + "/" + root_name + "/" + folder_name + Get8DirName(extracted_number)
								DirAccess.make_dir_absolute(path)
								target_folder = DirAccess.open(path)
						angle = extracted_number
					var absolute_path = folder.get_current_dir() + "/" + filename
					var target_path = target_folder.get_current_dir() + "/" + filename
					if %Skip.value > 0:
						if extracted_number % %Skip.value == 0:
							DirAccess.copy_absolute(absolute_path, target_path)
					else:
						DirAccess.copy_absolute(absolute_path, target_path)
		%Log.text = "FILES PROPERLY SORTED IN : " + str(parent.get_current_dir() + "/" + root_name + "/")
	else:
		%Log.text = "Failed to process : " + str(folder_name)

func Get4DirName(extracted_number):
	match(extracted_number):
		1: return "_FRONT_"
		2: return "_LEFT_"
		3: return "_BACK_"
		4: return "_RIGHT_"
	return "_dir" + str(extracted_number)

func Get8DirName(extracted_number):
	match(extracted_number):
		1: return "_FRONT_"
		2: return "_FRONT_LEFT_"
		3: return "_LEFT_"
		4: return "_BACK_LEFT_"
		5: return "_BACK_"
		6: return "_BACK_RIGHT_"
		7: return "_RIGHT_"
		8: return "_FRONT_RIGHT_"
	return "_dir" + str(extracted_number)

func SortMugenNames():
	pass
