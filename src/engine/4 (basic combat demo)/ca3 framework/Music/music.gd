extends Node

func PLAYSELECT():
	$Select.play()

func PLAYSONG():
	var i = randi_range(0, 10)
	
	if i > 5:
		$AurelioSong.play()
	else:
		$RaulSong.play()


func _on_aurelio_song_finished():
	PLAYSONG()

func _on_raul_song_finished():
	PLAYSONG()

func STOPSONG():
	$AurelioSong.stop()
	$RaulSong.stop()

func HIT():
	$HIT.pitch_scale = randf_range(0.5, 1.5)
	$HIT.play()

func Slash():
	$Slash.play(0.6)
