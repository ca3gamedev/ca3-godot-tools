extends Node2D

var gui_name = "battle gui"
var gui

var TimeLeft = 100

func _ready():
	VariableNodes.GUI = self
	TimeLeft = 100
	gui = $GUI
	
	await get_tree().process_frame
	
	gui.get_node("CanvasLayer/HP").value = VariableNodes.HP
	gui.get_node("CanvasLayer/HeroeName").text = "Heroe Salchichon"
	CHANGEMANA()

func CHANGEHP():
	gui.get_node("CanvasLayer/HP").value = VariableNodes.HP

func _process(delta):
	TimeLeft -= (delta * ((VariableNodes.Level / 4) + 1)) * 0.3


func Update():
	$GUI/CanvasLayer/EnemiesSize.text = str(get_tree().get_nodes_in_group("ENEMY").size() / 3)
	$GUI/CanvasLayer/TimeLeft.value = TimeLeft 
	$GUI/CanvasLayer/Combo.text = str(VariableNodes.Combo)
	$GUI/CanvasLayer/MaxCombo.text = str(VariableNodes.MaxCombo)
	
func CHANGEMANA():
	gui.get_node("CanvasLayer/Mana").value = VariableNodes.Mana


func _on_timer_timeout():
	Update()

func HIDE():
	$GUI/CanvasLayer.hide()

func SHOW():
	$GUI/CanvasLayer.show()
