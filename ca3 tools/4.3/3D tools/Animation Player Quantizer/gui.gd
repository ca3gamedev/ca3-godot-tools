extends Node

var frame_duration : float = 0.2

func _on_frame_duration_set_pressed():
	if %FrameDuration.text.is_valid_float():
		frame_duration = float(%FrameDuration.text)
	
	%FrameDurationLog.text = str(frame_duration)
	%FrameDuration.text = str(frame_duration)
