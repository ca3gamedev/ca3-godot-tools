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
		CreateNewFrames(%EightDir.selected, %HitboxManager.pre_name, duration, %EnableHitboxCheck.button_pressed)
	
	%NextPreviousFrame.UpdateHitbox()
	%NextPreviousFrame.UpdateHitboxFrame()


func CreateNewFrames(eightdir, current_anim, time, key):
	
	if eightdir == 0 or eightdir == 1:
		AddNewFrame("sprites/" + current_anim + "_FRONT_", time, key)
		AddNewFrame("sprites/" + current_anim + "_BACK_", time, key)
		AddNewFrame("sprites/" + current_anim + "_RIGHT_", time, key)
		AddNewFrame("sprites/" + current_anim + "_LEFT_", time, key)

	if eightdir == 1:
		AddNewFrame("sprites/" + current_anim + "_FRONT_RIGHT_", time, key)
		AddNewFrame("sprites/" + current_anim + "_FRONT_LEFT_", time, key)
		AddNewFrame("sprites/" + current_anim + "_BACK_RIGHT_", time, key)
		AddNewFrame("sprites/" + current_anim + "_BACK_LEFT_", time, key)

func AddNewFrame(current_anim, time, key):
	var anims = %NextPreviousHitbox.AttackHitboxPlayer.get_animation(current_anim)
	for track in anims.get_track_count():
		if anims.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:disabled"):
			anims.track_insert_key(track, time, key)
		if anims.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:position"):
			anims.track_insert_key(track, time, %HitboxPosGUI.Pos)
		if anims.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D/DebugAttackBox:color"):
			#if false, it means the debug color is off active hurtbox
			if not key:
				anims.track_insert_key(track, time, Color8(219, 24, 78, 212))
			else:
				anims.track_insert_key(track, time, Color8(185, 15, 64, 100))


func _on_play_hitbox_pressed():
	%NextPreviousHitbox.AttackHitboxPlayer.play(%NextPreviousFrame.current_anim)


func _on_playall_pressed():
	%NextPreviousHitbox.AttackHitboxPlayer.play(%NextPreviousFrame.current_anim)
	%NextPreviousFrame.AnimationPLayerSprites.play(%NextPreviousFrame.current_anim)


func _on_stopall_pressed():
	%NextPreviousHitbox.AttackHitboxPlayer.stop()
	%NextPreviousFrame.AnimationPLayerSprites.stop()
