extends Node


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
	"up": 4194320,
	"TutorialTips" : true
}

@onready var game_options = options.duplicate(true)


func _ready():
	%OptionsMenue.hide()
	LOAD()
	FULLSCREEN()
	Music.SetVolume(game_options.Music)


func LOAD():
	var ruta_archivo := "user://game_options.json"
	if FileAccess.file_exists(ruta_archivo):
		var file := FileAccess.open(ruta_archivo, FileAccess.READ)
		var contenido = file.get_as_text()
		file.close()
		
		var resultado = JSON.parse_string(contenido)
		game_options = resultado
	else:
		RESET()
		SAVE()
		LOAD()


func SAVE():
	var ruta_archivo := "user://game_options.json"
	var file := FileAccess.open(ruta_archivo, FileAccess.WRITE)
	
	if file:
		var contenido_json := JSON.stringify(Config.game_options, "\t")
		file.store_string(contenido_json)
		file.close()


func RESET():
	Config.game_options = Config.options.duplicate(true)


func FULLSCREEN():
	if not game_options.Fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
