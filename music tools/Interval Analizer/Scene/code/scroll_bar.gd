extends Node


func _on_track_scroll_value_changed(value):
	%KeyboardLabels.position.x = value
	%PianoRoll.position.x = value


func _on_track_vertical_value_changed(value):
	%PianoRoll.position.y = ( %PianoRoll.GetYOrigin() - ( value + %PianoRoll.GetYOrigin() )) / %Load.zoom
