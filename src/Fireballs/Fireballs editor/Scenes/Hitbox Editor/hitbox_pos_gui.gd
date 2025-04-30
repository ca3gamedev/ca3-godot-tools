extends Node

@export var Pos : Vector2i

func _ready():
	UpdatePos()

func _process(delta):
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		Pos = %Hitbox.to_local(%FireballSpawnGUI.get_global_mouse_position())
		%FireballSpawnGUI.position = Vector2(Pos)
		UpdatePos()

func UpdatePos():
	%POSLOG.text = str(Pos)
	%LOGSIZE.text = str(Pos)
	%FireballSpawnGUI.position = Pos

func _on_xpos_text_submitted(new_text):
	Pos.x = int(new_text)
	UpdatePos()


func _on_ypos_text_submitted(new_text):
	Pos.y = int(new_text)
	UpdatePos()

func _on_testpos_pressed():
	%FireballSpawnGUI.position = Pos
	UpdatePos()


func _on_changecurrent_pressed():
	if %NextPreviousFrame.current_anim == "":
		%LOG.text = "pls select an Animation"
		return
	
	var anims = %NextPreviousHitbox.AttackHitboxPlayer.get_animation(%NextPreviousFrame.current_anim)
	for track in anims.get_track_count():
		if anims.track_get_path(track) == NodePath("../Hitbox/fireball_spawn:position"):
			anims.track_insert_key(track, %HitboxFramesGUI.duration, %HitboxPosGUI.Pos)
		if anims.track_get_path(track) == NodePath("..:fireball_spawn"):
			anims.track_insert_key(track, %HitboxFramesGUI.duration, %EnableHitboxCheck.button_pressed)
		
	%NextPreviousHitbox.AttackHitboxPlayer.seek(%HitboxFramesGUI.duration, true)
	%NextPreviousFrame.UpdateHitbox()
	%NextPreviousFrame.UpdateHitboxFrame()



func RemoveAnimation(current_anim):
	
	var anims = %NextPreviousHitbox.AttackHitboxPlayer.get_animation(current_anim)
	if anims != null:
		
		for track in anims.get_track_count():
			if anims.track_get_path(track) == NodePath("../CollisionShape2D:position"):
				anims.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
			if anims.track_get_path(track) == NodePath("../CollisionShape2D:shape:size"):
				anims.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
			if anims.track_get_path(track) == NodePath("../CollisionShape2D:debug_color"):
				anims.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
			if anims.track_get_path(track) == NodePath("../CollisionShape2D:disabled"):
				anims.track_remove_key_at_time(track, %HitboxFramesGUI.duration)


func _on_remove_change_hitbox_pressed():
	
	if %HitboxManager.pre_name == "":
		%LOG.text = "PRESELECT NOT SELECTED, pls select an animation"
	else:
		RemoveOldFrames(%EightDir.selected, %HitboxManager.pre_name)
	
	%NextPreviousFrame.UpdateHitbox()
	%NextPreviousFrame.UpdateHitboxFrame()


func RemoveOldFrames(eightdir, current_anim):
	
	if eightdir == 0 or eightdir == 1:
		RemoveAnimation("sprites/" + current_anim + "_FRONT_")
		RemoveAnimation("sprites/" + current_anim + "_BACK_")
		RemoveAnimation("sprites/" + current_anim + "_RIGHT_")
		RemoveAnimation("sprites/" + current_anim + "_LEFT_")

	if eightdir == 1:
		RemoveAnimation("sprites/" + current_anim + "_FRONT_RIGHT_")
		RemoveAnimation("sprites/" + current_anim + "_FRONT_LEFT_")
		RemoveAnimation("sprites/" + current_anim + "_BACK_RIGHT_")
		RemoveAnimation("sprites/" + current_anim + "_BACK_LEFT_")
