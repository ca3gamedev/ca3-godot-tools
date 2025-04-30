extends Node

@export var duration : float = 0.1

func _ready():
	%HitboxTimeFrameLOG.text = str(duration)


func _on_hitbox_time_frame_text_changed(new_text):
	duration = float(new_text)
	%HitboxTimeFrameLOG.text = str(duration)

func _on_hitbox_time_frame_text_submitted(new_text):
	duration = float(new_text)
	%HitboxTimeFrameLOG.text = str(duration)


func _on_add_new_hitbox_pressed():
	
	if %HitboxManager.pre_name == "":
		%LOG.text = "PRESELECT NOT SELECTED, pls select an animation"
	else:
		CreateNewFrames(%EightDir.selected, %HitboxManager.pre_name, duration, %EnableHitboxCheck.button_pressed, %HitboxPosGUI.Pos)
	
	%NextPreviousFrame.UpdateHitbox()
	%NextPreviousFrame.UpdateHitboxFrame()


func CreateNewFrames(eightdir, current_anim, time, key, pos):
	
	if eightdir == 0 or eightdir == 1:
		AddNewFrame("sprites/" + current_anim + "_FRONT_", time, key, pos)
		AddNewFrame("sprites/" + current_anim + "_BACK_", time, key, pos)
		AddNewFrame("sprites/" + current_anim + "_RIGHT_", time, key, pos)
		AddNewFrame("sprites/" + current_anim + "_LEFT_", time, key, pos)

	if eightdir == 1:
		AddNewFrame("sprites/" + current_anim + "_FRONT_RIGHT_", time, key, pos)
		AddNewFrame("sprites/" + current_anim + "_FRONT_LEFT_", time, key, pos)
		AddNewFrame("sprites/" + current_anim + "_BACK_RIGHT_", time, key, pos)
		AddNewFrame("sprites/" + current_anim + "_BACK_LEFT_", time, key, pos)

func AddNewFrame(current_anim, time, key, pos):
	var anims = %NextPreviousHitbox.AttackHitboxPlayer.get_animation(current_anim)
	if anims != null:
		
		var track_index = anims.find_track("..:fireball_spawn", Animation.TYPE_VALUE)
		if track_index == -1:
			track_index = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "..:fireball_spawn")
		
		var track_index2 = anims.find_track("../Hitbox/fireball_spawn:position", Animation.TYPE_VALUE)
		if track_index2 == -1:
			track_index2 = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "../Hitbox/fireball_spawn:position")
		
		for track in anims.get_track_count():
			if anims.track_get_path(track) == NodePath("..:fireball_spawn"):
				anims.track_insert_key(track, time, key)
			if anims.track_get_path(track) == NodePath("../Hitbox/fireball_spawn:position"):
				anims.track_insert_key(track, time, pos)


func _on_play_hitbox_pressed():
	%NextPreviousHitbox.AttackHitboxPlayer.play(%NextPreviousFrame.current_anim)


func _on_playall_pressed():
	if %NextPreviousFrame.current_anim == "":
		%LOG.text = "NOT SELECTED ANY ANIM"
		return
	%NextPreviousHitbox.AttackHitboxPlayer.play(%NextPreviousFrame.current_anim)
	%NextPreviousFrame.AnimationPLayerSprites.play(%NextPreviousFrame.current_anim)


func _on_stopall_pressed():
	%NextPreviousHitbox.AttackHitboxPlayer.stop()
	%NextPreviousFrame.AnimationPLayerSprites.stop()
