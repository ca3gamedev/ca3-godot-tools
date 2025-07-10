extends Node

var selectedmotion = "none"
var selectedirection = "none"
var selectedbutton = "none"


func _on_hadouken_pressed():
	selectedmotion = "hadouken"
	$"../SelectedMotionSpecial".text = "Hadouken"


func _on_dragon_punch_pressed():
	selectedmotion = "dragonpunch"
	$"../SelectedMotionSpecial".text = "Dragon Punch"



func _on_half_circle_pressed():
	selectedmotion = "halfcircle"
	$"../SelectedMotionSpecial".text = "Half Circle"


func _on_full_circle_pressed():
	selectedmotion = "fullcircle"
	$"../SelectedMotionSpecial".text = "Full Circle"


func _on_left_pressed():
	selectedirection = "left"
	$"../SelectedDirectionSpecial".text = selectedirection


func _on_right_pressed():
	selectedirection = "right"
	$"../SelectedDirectionSpecial".text = selectedirection


func _on_dir_8_pressed():
	selectedirection = "8 directions"
	$"../SelectedDirectionSpecial".text = selectedirection


func _on_a_pressed():
	selectedbutton = "A"
	$"../SelectedButtonSpecial".text = selectedbutton

func _on_b_pressed():
	selectedbutton = "B"
	$"../SelectedButtonSpecial".text = selectedbutton


func _on_c_pressed():
	selectedbutton = "C"
	$"../SelectedButtonSpecial".text = selectedbutton



func _on_d_pressed():
	selectedbutton = "D"
	$"../SelectedButtonSpecial".text = selectedbutton


func _on_x_pressed():
	selectedbutton = "X"
	$"../SelectedButtonSpecial".text = selectedbutton



func _on_y_pressed():
	selectedbutton = "Y"
	$"../SelectedButtonSpecial".text = selectedbutton



func _on_z_pressed():
	selectedbutton = "Z"
	$"../SelectedButtonSpecial".text = selectedbutton

func _on_w_pressed():
	selectedbutton = "W"
	$"../SelectedButtonSpecial".text = selectedbutton
