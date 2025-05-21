extends Node

@export var HitboxPos : Vector2i
@export var HurtboxPos : Vector2i
@export var HitboxSize : Vector2i
@export var HurtboxSize : Vector2i
@export var HadoukenPos : Vector2i

@export var HitboxCollision : CollisionShape2D
@export var HurtboxCollision : CollisionShape2D
@export var HadoukenSpawn : Node2D

func _ready():
	HitboxPos = Vector2i.ZERO
	HurtboxPos = Vector2i.ZERO
	HitboxSize = Vector2i(50, 50)
	HurtboxSize = Vector2i(50, 50)
	HadoukenPos = Vector2i.ZERO
	
	UpdatePos()


func _process(delta):
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		match (%TypeGUI.action):
			"Hitbox Pos" : 
				HitboxPos = %Hitbox.to_local(%FireballSpawnGUI.get_global_mouse_position())
				HitboxCollision.position = Vector2(HitboxPos)
				UpdatePos()
			"Hitbox Size" :
				HitboxPos = %Hitbox.to_local(%FireballSpawnGUI.get_global_mouse_position())
				HitboxCollision.position = Vector2(HitboxPos)
				UpdatePos()
			"Hurtbox Pos" :
				HurtboxPos = %Hitbox.to_local(%FireballSpawnGUI.get_global_mouse_position())
				HurtboxCollision.position = Vector2(HurtboxPos)
				UpdatePos()
			"Hurtbox Size" :
				HurtboxPos = %Hitbox.to_local(%FireballSpawnGUI.get_global_mouse_position())
				HurtboxCollision.position = Vector2(HurtboxPos)
				UpdatePos()
			"Hadouken Pos" :
				HadoukenPos = %Hitbox.to_local(%FireballSpawnGUI.get_global_mouse_position())
				HadoukenSpawn.position = Vector2(HadoukenPos)
				%FireballSpawnGUI.position = Vector2(HadoukenPos)
				UpdatePos()
			

func UpdatePos():
	match (%TypeGUI.action):
		"Hitbox Pos" :
			%HitboxPosLog.text = str(HitboxPos)
			%HitboxSizeLog.text = str(HitboxSize)
		"Hurtbox Pos" :
			%HurtboxPosLog.text = str(HurtboxPos)
			%HurtboxSizeLog.text = str(HurtboxSize)
		"Hitbox Size" :
			%HitboxPosLog.text = str(HitboxPos)
			%HitboxSizeLog.text = str(HitboxSize)
		"Hurtbox Size" :
			%HurtboxPosLog.text = str(HurtboxPos)
			%HurtboxSizeLog.text = str(HurtboxSize)
		"Hadouken Pos" :
			%HadoukenPosLog.text = str(HadoukenPos)

func _on_xpos_text_submitted(new_text):
	match (%TypeGUI.action):
		"Hitbox Pos" : 
			HitboxSize.x = int(new_text)
			HitboxCollision.shape.size = HitboxSize
			%HitboxSizeLog.text = str(HitboxSize)
		"Hurtbox Pos" :
			HurtboxSize.x = int(new_text)
			HurtboxCollision.shape.size = HurtboxSize
			%HurtboxSizeLog.text = str(HurtboxSize)
		"Hadouken Pos" :
			HadoukenPos.x = int(new_text)
			UpdatePos()
		"Hitbox Size" :
			HitboxSize.x = int(new_text)
			HitboxCollision.shape.size = HitboxSize
			%HitboxSizeLog.text = str(HitboxSize)
		"Hurtbox Size" :
			HurtboxSize.x = int(new_text)
			HurtboxCollision.shape.size = HurtboxSize
			%HurtboxSizeLog.text = str(HurtboxSize)


func _on_ypos_text_submitted(new_text):
	match (%TypeGUI.action):
		"Hitbox Pos" : 
			HitboxSize.y = int(new_text)
			HitboxCollision.shape.size = HitboxSize
			%HitboxSizeLog.text = str(HitboxSize)
		"Hurtbox Pos" :
			HurtboxSize.y = int(new_text)
			HurtboxCollision.shape.size = HurtboxSize
			%HurtboxSizeLog.text = str(HurtboxSize)
		"Hadouken Pos" :
			HadoukenPos.y = int(new_text)
			UpdatePos()
		"Hitbox Size" :
			HitboxSize.y = int(new_text)
			HitboxCollision.shape.size = HitboxSize
			%HitboxSizeLog.text = str(HitboxSize)
		"Hurtbox Size" :
			HurtboxSize.y = int(new_text)
			HurtboxCollision.shape.size = HurtboxSize
			%HurtboxSizeLog.text = str(HurtboxSize)

func _on_testpos_pressed():
	match (%TypeGUI.action):
		"Hitbox Pos" : 
			HitboxPos = %Hitbox.to_local(%FireballSpawnGUI.get_global_mouse_position())
			HitboxCollision.position = Vector2(HitboxPos)
			UpdatePos()
		"Hurtbox Pos" :
			HurtboxPos = %Hitbox.to_local(%FireballSpawnGUI.get_global_mouse_position())
			HurtboxCollision.position = Vector2(HurtboxPos)
			UpdatePos()
		"Hadouken Pos" :
			HadoukenPos = %Hitbox.to_local(%FireballSpawnGUI.get_global_mouse_position())
			HadoukenSpawn.position = Vector2(HadoukenPos)
			%FireballSpawnGUI.position = Vector2(HadoukenPos)
			UpdatePos()


func _on_changecurrent_pressed():
	if %NextPreviousFrame.current_anim == "":
		%LOG.text = "pls select an Animation"
		return
	
	%HitboxFramesGUI.CreateSingleNewFrame()
	
	%NextPreviousHitbox.AttackHitboxPlayer.seek(%HitboxFramesGUI.duration, true)
	%NextPreviousHitbox.HurtboxPlayer.seek(%HitboxFramesGUI.duration, true)
	%NextPreviousFrame.UpdateHitbox()
	%NextPreviousFrame.UpdateHitboxFrame()



func RemoveAnimation(current_anim):
	if %NextPreviousFrame.current_anim == "":
		%LOG.text = "pls select an Animation"
		return
	
	
	var anims = %NextPreviousHitbox.AttackHitboxPlayer.get_animation(current_anim)
	if anims != null:
		
		for track in anims.get_track_count():
			if anims.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:shape:size"):
				anims.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
			if anims.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:disabled"):
				anims.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
			if anims.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:position"):
				anims.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
			if anims.track_get_path(track) == NodePath("../Hitbox/fireball_spawn:position"):
				anims.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
			if anims.track_get_path(track) == NodePath("..:fireball_spawn"):
				anims.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
	
	var anims2 = %NextPreviousHitbox.HurtboxPlayer.get_animation(current_anim)
	if anims2 != null:
		for track in anims2.get_track_count():
			if anims2.track_get_path(track) == NodePath("../CollisionShape2D:position"):
				anims2.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
			if anims2.track_get_path(track) == NodePath("../CollisionShape2D:shape:size"):
				anims2.track_remove_key_at_time(track, %HitboxFramesGUI.duration)
			if anims2.track_get_path(track) == NodePath("../CollisionShape2D:disabled"):
				anims2.track_remove_key_at_time(track, %HitboxFramesGUI.duration)


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
