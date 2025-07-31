extends Area3D

var near = false
@export var new_game : Node2D

func _ready():
	near = false
	%SaveLabel.hide()
	new_game.hide()

func _on_body_entered(body):
	if not body.is_in_group("PLAYER"):
		return
	near = true
	%SaveLabel.show()

func _on_body_exited(body):
	if not body.is_in_group("PLAYER"):
		return
	near = false
	%SaveLabel.hide()

func _process(delta):
	
	if near:
		if Input.is_action_just_released("D"):
			$"../".PAUSE()
			$"../".is_store = true
			new_game.START()
			new_game.show()
			$ScreenActive.start(0.01)


func _on_screen_active_timeout():
	new_game.GameLoaded = true
