extends Node

@export var selection = 0
@export var switchmode : bool

func _on_channel_tracks_item_selected(index):
	selection = index
	
	if switchmode:
		%PianoRoll.HideAllTrack()
		%PianoRoll.ShowTrack(int(%ChannelTracks.get_item_text(selection)))


func _process(delta):
	
	if Input.is_action_just_released("Hide"):
		%PianoRoll.HideTrack(int(%ChannelTracks.get_item_text(selection)))
	if Input.is_action_just_released("Show"):
		%PianoRoll.ShowTrack(int(%ChannelTracks.get_item_text(selection)))
	if Input.is_action_just_released("HideAll"):
		%PianoRoll.HideAllTrack()
	if Input.is_action_just_released("ShowAll"):
		%PianoRoll.ShowAllTrack()
	if Input.is_action_just_released("SwitchMode"):
		switchmode = !switchmode
		%SwitchMode.button_pressed = switchmode
	if Input.is_action_just_released("InteractiveGhosts"):
		%PianoRoll.interactive_ghosts = !%PianoRoll.interactive_ghosts
		%InteractiveMode.button_pressed = %PianoRoll.interactive_ghosts
		%PianoRoll.UpdateGhosts()


func _on_switch_mode_pressed():
	switchmode = %SwitchMode.button_pressed


func _on_interactive_mode_pressed():
	%PianoRoll.interactive_ghosts = !%PianoRoll.interactive_ghosts
	%InteractiveMode.button_pressed = %PianoRoll.interactive_ghosts
	%PianoRoll.UpdateGhosts()
