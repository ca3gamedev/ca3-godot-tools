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
