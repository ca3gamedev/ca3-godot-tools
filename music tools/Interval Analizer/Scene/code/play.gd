extends Node

var position : float = 0.0

func _on_play_pressed():
	
	if %MidiPlayer.file == "":
		%LOG.text = "There's not current midi file LOADED"
	if %MidiPlayer.soundfont == "":
		%LOG.text = "There's not current soundfont (.sf2) LOADED"
	
	if %MidiPlayer.file != "" and %MidiPlayer.soundfont != "":
		%MidiPlayer.play(position)


func _on_stop_pressed():
	
	if %MidiPlayer.file == "":
		%LOG.text = "There's not current midi file LOADED"
	if %MidiPlayer.soundfont == "":
		%LOG.text = "There's not current soundfont (.sf2) LOADED"
	
	if %MidiPlayer.file != "" and %MidiPlayer.soundfont != "":
		position = 0.0
		%MidiPlayer.stop()


func _on_pause_pressed():
	
	if %MidiPlayer.file == "":
		%LOG.text = "There's not current midi file LOADED"
	if %MidiPlayer.soundfont == "":
		%LOG.text = "There's not current soundfont (.sf2) LOADED"
	
	if %MidiPlayer.file != "" and %MidiPlayer.soundfont != "":
		position = %MidiPlayer.position
		%MidiPlayer.stop()
