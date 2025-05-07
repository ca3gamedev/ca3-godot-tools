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
		CreateNewFrames(%EightDir.selected, %HitboxManager.pre_name, duration, %EnableHitboxCheck.button_pressed, %HitboxPosGUI.HitboxPos, %HitboxPosGUI.HitboxSize, 0)
		CreateNewFrames(%EightDir.selected, %HitboxManager.pre_name, duration, %EnableHitboxCheck.button_pressed, %HitboxPosGUI.HurtboxPos, %HitboxPosGUI.HurtboxSize, 1)
		CreateNewFrames(%EightDir.selected, %HitboxManager.pre_name, duration, %EnableHitboxCheck.button_pressed, %HitboxPosGUI.HadoukenPos, Vector2.ZERO, 2)
	
	%NextPreviousFrame.UpdateHitbox()
	%NextPreviousFrame.UpdateHitboxFrame()


func CreateNewFrames(eightdir, current_anim, time, key, pos, size, id):
	
	if %NextPreviousFrame.current_anim == "":
		%LOG.text = "pls select an Animation"
		return
	
	if eightdir == 0 or eightdir == 1:
		AddNewFrame("sprites/" + current_anim + "_FRONT_", time, key, pos, size, id)
		AddNewFrame("sprites/" + current_anim + "_BACK_", time, key, pos, size, id)
		AddNewFrame("sprites/" + current_anim + "_RIGHT_", time, key, pos, size, id)
		AddNewFrame("sprites/" + current_anim + "_LEFT_", time, key, pos, size, id)

	if eightdir == 1:
		AddNewFrame("sprites/" + current_anim + "_FRONT_RIGHT_", time, key, pos, size, id)
		AddNewFrame("sprites/" + current_anim + "_FRONT_LEFT_", time, key, pos, size, id)
		AddNewFrame("sprites/" + current_anim + "_BACK_RIGHT_", time, key, pos, size, id)
		AddNewFrame("sprites/" + current_anim + "_BACK_LEFT_", time, key, pos, size, id)

func CreateSingleNewFrame():
	var size = %HitboxPosGUI.HitboxSize
	var pos = %HitboxPosGUI.HitboxPos
	var time = %HitboxFramesGUI.duration
	var key = %EnableHitboxCheck.button_pressed
	var current_anim = %NextPreviousFrame.current_anim
	var id = %TypeofAction.selected
	var new_id = 0
	match(id):
		0 : 
			new_id = 0
			size = %HitboxPosGUI.HitboxSize
			pos = %HitboxPosGUI.HitboxPos
		1 : 
			new_id = 0
			size = %HitboxPosGUI.HitboxSize
			pos = %HitboxPosGUI.HitboxPos
		2 : 
			new_id = 1
			size = %HitboxPosGUI.HurtboxSize
			pos = %HitboxPosGUI.HurtboxPos
		3 : 
			new_id = 1
			size = %HitboxPosGUI.HurtboxSize
			pos = %HitboxPosGUI.HurtboxPos
		4 : 
			new_id = 2
			size = %HitboxPosGUI.HurtboxSize
			pos = %HitboxPosGUI.HadoukenPos
	AddNewFrame(current_anim, time, key, pos, size, new_id)


func AddNewFrame(current_anim, time, key, pos, size, id):
	match(id):
		0 : AddNewHitboxFrame(time, key, pos, size)
		1 : AddNewHurtboxFrame(time, key, pos, size)
		2 : AddNewHadoukenFrame(time, key, pos)

func AddNewHitboxFrame(time, key, pos, size):
	var current_anim = %NextPreviousFrame.current_anim
	var anims = %NextPreviousHitbox.AttackHitboxPlayer.get_animation(current_anim)
	if anims != null:
		
		var track_index = anims.find_track("../Hitbox/CollisionShape2D:shape:size", Animation.TYPE_VALUE)
		if track_index == -1:
			track_index = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "../Hitbox/CollisionShape2D:shape:size")
		
		var track_index2 = anims.find_track("../Hitbox/CollisionShape2D:disabled", Animation.TYPE_VALUE)
		if track_index2 == -1:
			track_index2 = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "../Hitbox/CollisionShape2D:disabled")
			
		var track_index3 = anims.find_track("../Hitbox/CollisionShape2D:position", Animation.TYPE_VALUE)
		if track_index3 == -1:
			track_index3 = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "../Hitbox/CollisionShape2D:position")
		
		for track in anims.get_track_count():
			if anims.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:shape:size"):
				anims.track_insert_key(track, time, size)
			if anims.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:disabled"):
				anims.track_insert_key(track, time, key)
			if anims.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:position"):
				anims.track_insert_key(track, time, pos)

func AddNewHurtboxFrame(time, key, pos, size):
	var current_anim = %NextPreviousFrame.current_anim
	var anims = %NextPreviousHitbox.HurtboxPlayer.get_animation(current_anim)
	if anims != null:
		
		var track_index = anims.find_track("../CollisionShape2D:position", Animation.TYPE_VALUE)
		if track_index == -1:
			track_index = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "../CollisionShape2D:position")
		
		var track_index2 = anims.find_track("../CollisionShape2D:shape:size", Animation.TYPE_VALUE)
		if track_index2 == -1:
			track_index2 = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "../CollisionShape2D:shape:size")
			
		var track_index3 = anims.find_track("../CollisionShape2D:disabled", Animation.TYPE_VALUE)
		if track_index3 == -1:
			track_index3 = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "../CollisionShape2D:disabled")
		
		for track in anims.get_track_count():
			if anims.track_get_path(track) == NodePath("../CollisionShape2D:position"):
				anims.track_insert_key(track, time, pos)
			if anims.track_get_path(track) == NodePath("../CollisionShape2D:disabled"):
				anims.track_insert_key(track, time, key)
			if anims.track_get_path(track) == NodePath("../CollisionShape2D:shape:size"):
				anims.track_insert_key(track, time, size)

func AddNewHadoukenFrame(time, key, pos):
	var current_anim = %NextPreviousFrame.current_anim
	var anims = %NextPreviousHitbox.AttackHitboxPlayer.get_animation(current_anim)
	if anims != null:
		
		var track_index = anims.find_track("../Hitbox/fireball_spawn:position", Animation.TYPE_VALUE)
		if track_index == -1:
			track_index = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "../Hitbox/fireball_spawn:position")
		
		var track_index2 = anims.find_track("..:fireball_spawn", Animation.TYPE_VALUE)
		if track_index2 == -1:
			track_index2 = anims.add_track(Animation.TYPE_VALUE)
			anims.track_set_path(track_index, "..:fireball_spawn")
			
		
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
