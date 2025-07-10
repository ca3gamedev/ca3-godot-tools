extends Node2D

var waiting_for_input = false
var action_to_rebind = "jump"

var options = {
	"A": 90,
	"B": 88,
	"C": 67,
	"D": 86,
	"Fullscreen": false,
	"Music": 100.0,
	"SFX": 100.0,
	"down": 4194322,
	"left": 4194319,
	"right": 4194321,
	"up": 4194320
}

var game_options

func _on_music_value_changed(value):
	%MusicLog.text = str(int(value))
	game_options.Music = value


func _on_sfx_value_changed(value):
	%SFXLog.text = str(int(value))
	game_options.SFX = value
