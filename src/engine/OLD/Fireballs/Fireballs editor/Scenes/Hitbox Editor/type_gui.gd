extends Node

@export var action : String

func _ready():
	action = %TypeofAction.get_item_text(0)

func _on_typeof_action_item_selected(index):
	
	action = %TypeofAction.get_item_text(index)

func _process(delta):
	
	if Input.is_action_just_released("hadouken"):
		%TypeofAction.selected = 4
		action = %TypeofAction.get_item_text(4)
	if Input.is_action_just_released("hurtbox"):
		%TypeofAction.selected = 3
		action = %TypeofAction.get_item_text(3)
	if Input.is_action_just_released("hitbox"):
		%TypeofAction.selected = 1
		action = %TypeofAction.get_item_text(1)
