extends Node

var selected_button = "none"
var selected_dir = Vector2i.ZERO

@export var buttonscene : PackedScene
@onready var mybutton = get_tree().get_root().get_node("INPUT/FSM/Button")


func _ready():
	$"../SelectedDir".text = str(selected_dir)

func _on_none_pressed():
	selected_dir = Vector2i.ZERO
	$"../SelectedDir".text = str(selected_dir)


func _on_left_pressed():
	selected_dir = Vector2i(-1, 0)
	$"../SelectedDir".text = str(selected_dir)


func _on_down_pressed():
	selected_dir = Vector2i(0, 1)
	$"../SelectedDir".text = str(selected_dir)


func _on_right_pressed():
	selected_dir = Vector2i(1, 0)
	$"../SelectedDir".text = str(selected_dir)


func _on_up_pressed():
	selected_dir = Vector2i(0, -1)
	$"../SelectedDir".text = str(selected_dir)

func _on_up_left_pressed():
	selected_dir = Vector2i(-1, -1)
	$"../SelectedDir".text = str(selected_dir)


func _on_down_left_pressed():
	selected_dir = Vector2i(-1, 1)
	$"../SelectedDir".text = str(selected_dir)


func _on_down_right_pressed():
	selected_dir = Vector2i(1, 1)
	$"../SelectedDir".text = str(selected_dir)


func _on_up_right_pressed():
	selected_dir = Vector2i(1, -1)
	$"../SelectedDir".text = str(selected_dir)


func _on_a_pressed():
	selected_button = "A"
	$"../SelectedButton".text = "A"


func _on_b_pressed():
	selected_button = "B"
	$"../SelectedButton".text = "B"


func _on_c_pressed():
	selected_button = "C"
	$"../SelectedButton".text = "C"


func _on_d_pressed():
	selected_button = "D"
	$"../SelectedButton".text = "D"


func _on_x_pressed():
	selected_button = "W"
	$"../SelectedButton".text = "W"


func _on_y_pressed():
	selected_button = "X"
	$"../SelectedButton".text = "X"


func _on_z_pressed():
	selected_button = "Y"
	$"../SelectedButton".text = "Y"


func _on_w_pressed():
	selected_button = "Z"
	$"../SelectedButton".text = "Z"


func _on_add_buttons_pressed():
	if selected_button == "none":
		%ButtonLOG.text = "No button selected"
		return
	if CheckDuplicates():
		%ButtonLOG.text = "Button Duplicated"
		return
	
	var tmp = buttonscene.instantiate()
	tmp.dir = selected_dir
	tmp.button = selected_button
	%InputListButtons.add_item(str(selected_dir) + " : " + selected_button)
	mybutton.add_child(tmp)
	tmp.set_owner(mybutton)
	%ButtonLOG.text = "Button Added"

func CheckDuplicates():
	
	var childs = mybutton.get_children()
	
	for i in childs:
		if i.dir == selected_dir and i.button == selected_button:
			return true
	
	return false
