extends Node

@export var Static : PackedScene
@export var Horizontal : PackedScene
@export var Vertical : PackedScene
@export var Plaformer : PackedScene
@export var Directions4 : PackedScene
@export var Directions8 : PackedScene

func _ready():
	%CurrentIdle.text = "Static"
	%CurrentMovement.text = %CurrentIdle.text


func _on_horizontal_pressed():
	%CurrentIdle.text = "Horizontal"


func _on_vertical_pressed():
	%CurrentIdle.text = "Vertical"


func _on_platformer_pressed():
	%CurrentIdle.text = "Platformer"


func _on_directions_pressed():
	%CurrentIdle.text = "4 Directions"


func _on_8directions_pressed():
	%CurrentIdle.text = "8 Directions"


func _on_static_pressed():
	%CurrentIdle.text = "Static"


func _on_change_pressed():
	%CurrentMovement.text = %CurrentIdle.text
	
	var tmp
	
	match (%CurrentMovement.text):
		"Static" : tmp = Static.instantiate()
		"Horizontal" : tmp = Horizontal.instantiate()
		"Vertical" : tmp = Vertical.instantiate()
		"Platformer" : tmp = Plaformer.instantiate()
		"4 Directions" : tmp = Directions4.instantiate()
		"8 Directions" : tmp = Directions8.instantiate()
	
	var children = $"../../INPUT/FSM/Move".get_children()
	
	children[0].queue_free()
	
	$"../../INPUT/FSM/Move".add_child(tmp)
