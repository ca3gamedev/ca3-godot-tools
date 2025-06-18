extends CharacterBody3D

@export var near : bool


func _ready():
	$Dialog.hide()
	
func _process(delta):
	
	if near and Input.is_action_just_released("A"):
		$"../../".DIALOGPAUSE()
