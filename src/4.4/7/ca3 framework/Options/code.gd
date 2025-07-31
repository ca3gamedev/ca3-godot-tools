extends Node

@onready var Root = $".."

func _ready():
	Config.LOAD()
	%KeysRemap.ChangeGameActions()
	ResetUpdate()
	%KeysRemap.UpdateKeysLabels()
	Config.FULLSCREEN()
	Frame.LOG([["Options Loaded!"], false], 4.0, true)
	%TutorialTips.button_pressed = Config.game_options.TutorialTips

func _on_reset_pressed():
	Config.RESET()
	RESET()
	Music.SetVolume(Config.game_options.Music)
	Frame.LOG([["Options Reset!."], false], 4.0, true)


func RESET():
	%TutorialTips.button_pressed = Config.game_options.TutorialTips
	%KeysRemap.ChangeGameActions()
	ResetUpdate()
	%KeysRemap.UpdateKeysLabels()
	Config.FULLSCREEN()
	

func ResetUpdate():
	%FullScreen.button_pressed = Config.game_options.Fullscreen
	%Music.value = Config.game_options.Music
	%SFX.value = Config.game_options.SFX
	%MusicLog.text = str(Config.game_options.Music)
	%SFXLog.text = str(Config.game_options.SFX)


func _on_save_pressed():
	Config.SAVE()
	Frame.LOG([["Options Saved!!!."], false], 4.0, true)

func _on_full_screen_pressed():
	Config.game_options.Fullscreen = %FullScreen.button_pressed
	Config.FULLSCREEN()


func _on_tutorial_tips_pressed():
	Config.game_options.TutorialTips = %TutorialTips.button_pressed
	if not Config.game_options.TutorialTips:
		Frame.StopLOG()
	else:
		Frame.LOGSTART()
