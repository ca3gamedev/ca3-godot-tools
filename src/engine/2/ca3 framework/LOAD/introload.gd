extends Node2D

@export var root_json : String
@export var root_list_json : String
@export var root_folder : String

@export var TITLE_SCREEN : String

func _ready():
	
	#LOAD THE MOD SELECTOR
	
	var root = FileAccess.open(root_json, FileAccess.READ)
	
	if root == null:
		$LOG.text = "Failed to open the root data json"
		return
	
	$LOG.text = "Root json loaded"
	
	var root_content = root.get_as_text()
	root.close()
	
	var root_result = JSON.parse_string(root_content)
	if root_result == null:
		$LOG.text = "Failed to parse JSON in file"
		return 
	
	FilePaths.pack_default = root_result["default"]
	
	# LOAD THE MOD ARRAY LIST OF PATHS
	
	var root_list = FileAccess.open(root_list_json, FileAccess.READ)
	if root_list == null:
		$LOG.text = "Failed to open the root mod lists json"
		return
	
	$LOG.text = "Mod List json loaded"
	
	var root_list_content = root_list.get_as_text()
	root_list.close()
	
	var root_result_list = JSON.parse_string(root_list_content)
	if root_result_list == null:
		$LOG.text = "Failed to parse mod list JSON in file"
		return 
	
	if len(root_result_list) < 1:
		$LOG.text = "There's not mods to load on the pack list json"
		return
	else:
		$LOG.text = "Mod folder not empty, loading..."
	
	# CHARACTER SELECTED LOADING
	
	FilePaths.root_folder = root_folder + "/" + root_result_list[FilePaths.pack_default]
	
	var characters_selection_json = FileAccess.open(FilePaths.root_folder + "/objects/characters/selection.json", FileAccess.READ)
	
	if characters_selection_json == null:
		$LOG.text = "Failed to open the character selection json"
		return
	
	$LOG.text = "Character default json loaded"
	
	var character_default = characters_selection_json.get_as_text()
	characters_selection_json.close()
	
	var character_selection = JSON.parse_string(character_default)
	if character_selection == null:
		$LOG.text = "Failed to parse Character default JSON"
		return
	
	FilePaths.Characters_selected = character_selection
	
	# CHARACTERS SELECTION JSON LOADING
	
	var character_list_file = FileAccess.open(FilePaths.root_folder + "/objects/characters/characters.json", FileAccess.READ)
	
	if character_list_file == null:
		$LOG.text = "Failed to open the character list json"
		return
	
	$LOG.text = "Character list json loaded"
	
	var character_list = character_list_file.get_as_text()
	character_list_file.close()
	
	var character_list_json = JSON.parse_string(character_list)
	if character_list_json == null:
		$LOG.text = "Failed to parse Character list JSON"
		return
		
	if len(character_list_json) < 1:
		$LOG.text = "There's not Characters to load on the pack list json"
		return
	else:
		$LOG.text = "Character folder not empty, loading..."
	
	FilePaths.Characters_list = character_list_json
	
	# LOAD CHARACTERS
	
	for i in FilePaths.Characters_list:
		var path = FilePaths.root_folder + "/objects/characters/" + i[0]
		
		var character_json = FileAccess.open(path, FileAccess.READ)
		var avatar = character_json.get_as_text()
		character_json.close()
		
		var current_avatar = JSON.parse_string(avatar)
		if current_avatar == null:
			$LOG.text = "Failed to parse Character json at " + "/objects/characters/" + i
			return
		
		FilePaths.Avatars.append(current_avatar)
	
	# LOAD GUI
	
	var guiroot = FileAccess.open(FilePaths.root_folder + "/gui/gui_config.json", FileAccess.READ)
	
	if guiroot == null:
		$LOG.text = "Failed to open the GUI root data json at " + FilePaths.root_folder + "/gui/gui_config.json"
		return
	
	$LOG.text = "GUI Root json loaded"
	
	var gui_root_content = guiroot.get_as_text()
	guiroot.close()
	
	var gui_root_result = JSON.parse_string(gui_root_content)
	if gui_root_result == null:
		$LOG.text = "Failed to parse GUI JSON"
		return 
	
	FilePaths.root_gui = gui_root_result

	
	
	# FINISH LOADING MOVE TOWARDS FIRST SCENE
	self.CHANGE_TO_TITLE.call_deferred()


func CHANGE_TO_TITLE():
	get_tree().change_scene_to_file(TITLE_SCREEN)
	
