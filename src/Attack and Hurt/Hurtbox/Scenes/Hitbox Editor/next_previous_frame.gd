extends Node

@export var current : int = 0
@export var max_frames : float = 0
@export var fps : int = 10
@export var AnimationPLayerSprites : AnimationPlayer
@export var frames_lenght : float = 0.1
@export var current_anim : String = ""



func _process(delta):
	
	if current_anim != "":
		
		if Input.is_action_just_released("PREVIOUS"):
			if current > 0:
				current -= 1
				UpdateCurrent()
		if Input.is_action_just_released("NEXT"):
			if current < max_frames:
				current += 1
				UpdateCurrent()


func _on_select_pressed():
	current_anim = %CurrentNode.get_item_text(%Load.current_index)
	%SelectedAnimLOG.text = current_anim
	max_frames = AnimationPLayerSprites.get_animation(current_anim).length / frames_lenght
	AnimationPLayerSprites.play(current_anim)
	AnimationPLayerSprites.stop()
	current = 0
	UpdateFrames()
	UpdateCurrent()
	%Load.LOADNODE()
	UpdateHitbox()
	UpdateHitboxFrame()

func UpdateFrames():
	%Frames.clear()
	%Framesid.clear()
	var anims = AnimationPLayerSprites.get_animation(current_anim)
	var max_f = 0
	for track in anims.get_track_count():
		for key in anims.track_get_key_count(track):
			var time = anims.track_get_key_time(track, key)
			%Frames.add_item(str(time))
			%Framesid.add_item(str(key))
			if key > max_f:
				max_f = key
	max_frames = max_f + 1
	


func _on_set_pressed():
	
	UpdateCurrent()

func _on_framesid_item_selected(index):
	current = index


func _on_play_pressed():
	if current_anim != "":
		AnimationPLayerSprites.play(current_anim)

func UpdateCurrent():
	for i in %Framesid.item_count:
		%Framesid.set_item_custom_bg_color(i, Color.DIM_GRAY)
		%Frames.set_item_custom_bg_color(i, Color.DIM_GRAY)
	%Framesid.set_item_custom_bg_color(current, Color.BLUE)
	%Frames.set_item_custom_bg_color(current, Color.BLUE)
	AnimationPLayerSprites.seek(current * float(%Frames.get_item_text(current)), true)
	%NextPreviousHitbox.AttackHitboxPlayer.seek(current * float(%Frames.get_item_text(current)), true)


func UpdateHitbox():
	for i in %HitboxAnimations.item_count:
		%HitboxAnimations.set_item_custom_bg_color(i, Color.DIM_GRAY)
	
	for i in %HitboxAnimations.item_count:
		if current_anim == %HitboxAnimations.get_item_text(i):
			%HitboxAnimations.set_item_custom_bg_color(i, Color.BLUE)
	%NextPreviousHitbox.AttackHitboxPlayer.seek(current * float(%HitboxAnimations.get_item_text(current)), true)

func UpdateHitboxFrame():
	if current_anim == "":
		%LOG.text = "Animation not Selected"
		return
	
	%HitboxFrames.clear()
	%HitboxPosition.clear()
	%HitboxFramesBool.clear()
	%HitboxPositionPos.clear()
	var anims = %NextPreviousHitbox.AttackHitboxPlayer.get_animation(current_anim)
	for track in anims.get_track_count():
		for key in anims.track_get_key_count(track):
			if anims.track_get_path(track) == NodePath("../CollisionShape2D:position"):
				var time = anims.track_get_key_time(track, key)
				%HitboxFrames.add_item(str(time))
				var value = anims.track_get_key_value(track, key)
				%HitboxFramesBool.add_item(str(value))
			if anims.track_get_path(track) == NodePath("../CollisionShape2D:shape:size"):
				var time = anims.track_get_key_time(track, key)
				%HitboxPosition.add_item(str(time))
				var value = anims.track_get_key_value(track, key)
				%HitboxPositionPos.add_item(str(value))
	
	%NextPreviousHitbox.AttackHitboxPlayer.play(%NextPreviousFrame.current_anim)
	%NextPreviousHitbox.AttackHitboxPlayer.stop()
	%NextPreviousHitbox.AttackHitboxPlayer.seek(0.0, true)
	
func _on_stop_pressed():
	if current_anim != "":
		AnimationPLayerSprites.stop()
