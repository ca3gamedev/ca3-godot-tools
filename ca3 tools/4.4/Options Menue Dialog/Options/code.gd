extends Node

@onready var Root = $".."

func _ready():
	LOAD()
	%KeysRemap.ChangeGameActions()
	ResetUpdate()
	%KeysRemap.UpdateKeysLabels()
	FULLSCREEN()

func _on_reset_pressed():
	RESET()
	pass
	
func RESET():
	Root.game_options = Root.options.duplicate(true)
	%KeysRemap.ChangeGameActions()
	ResetUpdate()
	%KeysRemap.UpdateKeysLabels()
	FULLSCREEN()


func ResetUpdate():
	%FullScreen.button_pressed = Root.game_options.Fullscreen
	%Music.value = Root.game_options.Music
	%SFX.value = Root.game_options.SFX
	%MusicLog.text = str(Root.game_options.Music)
	%SFXLog.text = str(Root.game_options.SFX)


func _on_save_pressed():
	SAVE()



func SAVE():
	var ruta_archivo := "user://game_options.json"
	var file := FileAccess.open(ruta_archivo, FileAccess.WRITE)
	
	if file:
		var contenido_json := JSON.stringify(Root.game_options, "\t")
		file.store_string(contenido_json)
		file.close()
		print(Root.game_options)
		%LOG.text = "Options Saved!!!"
	else:
		%LOG.text = "There was an issue when saving, not file saved!"


func LOAD():
	var ruta_archivo := "user://game_options.json"
	if FileAccess.file_exists(ruta_archivo):
		var file := FileAccess.open(ruta_archivo, FileAccess.READ)
		var contenido = file.get_as_text()
		file.close()
		
		var resultado = JSON.parse_string(contenido)
		Root.game_options = resultado
		%LOG.text = "Options Loaded!"
	else:
		RESET()
		SAVE()
		LOAD()


func _on_full_screen_pressed():
	Root.game_options.Fullscreen = %FullScreen.button_pressed
	FULLSCREEN()

func FULLSCREEN():
	if not %FullScreen.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
