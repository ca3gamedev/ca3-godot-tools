extends Node2D

var gui_name = "battle gui"

func _ready():
	VariableNodes.GUI = self
	
	var tmp_path = FilePaths.root_folder + "/gui/" + FilePaths.root_gui["battle gui"]
	var tmp = load(tmp_path)
	var gui = tmp.instantiate()
	gui.name = gui_name
	add_child(gui)
	
	await get_tree().process_frame
	
	get_node(gui_name).get_node("CanvasLayer/HP").value = VariableNodes.HP
	var Character = FilePaths.Avatars[FilePaths.Characters_selected.get("default", 0)]
	var new_name = Character["name"].substr(0, min(Character["name"].length(), 20))
	get_node(gui_name).get_node("CanvasLayer/HeroeName").text = new_name

func CHANGEHP(hp):
	get_node(gui_name).get_node("GUI/CanvasLayer/HP").value = hp
