extends Node


func _on_quantize_all_pressed():
	
	if is_instance_valid(%AnimationPlayer.MyAnim):
		QuantizeAll()
	else:
		%Log.text = "NO ANIMATION PLAYER SELECTED"
	

func QuantizeAll():
	
	var anims = %AnimationPlayer.MyAnim.get_animation_list()
	
	for animation in anims:
		var current = %AnimationPlayer.MyAnim.get_animation(animation)
		for track in current.get_track_count():
			current.track_set_interpolation_loop_wrap(track, false)
			for key in current.track_get_key_count(track):
				var time = current.track_get_key_time(track, key)
				time *= 10
				time = round(time)
				time /= 10
				%AnimationPlayer.MyAnim.get_animation(animation).track_set_key_time(track, key, time)
	
	%AnimationPlayer.Update()
	
