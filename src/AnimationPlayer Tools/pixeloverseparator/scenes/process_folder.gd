extends Node

var dir
var dir_path = ""
var dir_selected = 0
var directories

func LOAD(folder):
	
	dir = DirAccess.open(folder)
	dir_path = folder
	
	if DirAccess.dir_exists_absolute(folder):
		%FolderList.clear()
		for i in dir.get_directories():
			%FolderList.add_item(i)
		directories = dir.get_directories()
	
	UpdateFiles()

func UpdateFiles():
	
	if DirAccess.open(dir_path):
		
		var folder = DirAccess.open(dir_path + "/" + directories[dir_selected])
		
		if folder:
			%FilesList.clear()
			for file in folder.get_files():
				%FilesList.add_item(file)


func _on_folder_list_item_selected(index):
	dir_selected = index
	UpdateFiles()
