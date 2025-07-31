extends Node2D

var waiting_for_input = false
var action_to_rebind = "jump"

func _ready():
	await get_tree().process_frame
	%Music.value = Config.game_options.Music
	%SFX.value = Config.game_options.SFX
	%MusicLog.text = str(int(%Music.value))
	%SFXLog.text =  str(int(%SFX.value))


func _on_music_value_changed(value):
	%MusicLog.text = str(int(value))
	Config.game_options.Music = value
	Music.SetVolume(Config.game_options.Music)


func _on_sfx_value_changed(value):
	%SFXLog.text =  str(int(value))
	Config.game_options.SFX = value


func _on_return_pressed():
	self.hide()
	if is_instance_valid(VariableNodes.GUI):
		VariableNodes.GUI.SHOW()


func _on_exit_pressed():
	Music.STOPSONG()
	self.hide()
	Transitions.Next = SceneDirectory.GetScreen("Title")
	Transitions.Start()
