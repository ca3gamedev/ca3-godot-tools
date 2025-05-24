extends Node2D

var gui_name = "battle gui"
var gui

func _ready():
	VariableNodes.GUI = self
	
	gui = $GUI
	
	await get_tree().process_frame
	
	gui.get_node("CanvasLayer/HP").value = VariableNodes.HP
	#var Character = FilePaths.Avatars[FilePaths.Characters_selected.get("default", 0)]
	#var new_name = Character["name"].substr(0, min(Character["name"].length(), 20))
	gui.get_node("CanvasLayer/HeroeName").text = "Heroe Salchichon"

func CHANGEHP():
	gui.get_node("CanvasLayer/HP").value = VariableNodes.HP

func _process(delta):
	
	$GUI/CanvasLayer/EnemiesSize.text = str(get_tree().get_nodes_in_group("ENEMY").size())
