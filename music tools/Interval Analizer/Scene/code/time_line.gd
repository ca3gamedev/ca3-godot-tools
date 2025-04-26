extends Node


func _process(delta):
	
	if %UpdateTimeline.button_pressed:
		%PianoRoll.SetTime(%MidiPlayer.position)
		%TrackVertical.value = %MidiPlayer.position
