extends Node

@onready var library = AnimationLibrary.new()

func NewAnimation(loop, pre_name, current_anim):
	var anim = Animation.new()
	anim.loop_mode = int(loop)
	anim.length = %NextPreviousFrame.AnimationPLayerSprites.get_animation(current_anim).length
	
	var frame_index2 = anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(frame_index2, "../CollisionShape2D:shape:size")
	anim.track_insert_key(frame_index2, 0.0, Vector2i(20, 40))
	anim.track_set_interpolation_type(frame_index2, 0)
	
	var frame_index3 = anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(frame_index3, "../CollisionShape2D:position")
	anim.track_insert_key(frame_index3, 0.0, Vector2i.ZERO)
	anim.track_set_interpolation_type(frame_index3, 0)
	
	var frame_index4 = anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(frame_index4, "../CollisionShape2D:disabled")
	anim.track_insert_key(frame_index4, 0.0, false)
	anim.track_set_interpolation_type(frame_index4, 0)
	
	var frame_index5 = anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(frame_index5, "../CollisionShape2D:debug_color")
	anim.track_insert_key(frame_index5, 0.0, Color8(7, 127, 148, 172))
	anim.track_set_interpolation_type(frame_index5, 0)
	
	library.add_animation(pre_name, anim)
	if %NextPreviousHitbox.AttackHitboxPlayer.has_animation_library("sprites"):
		%NextPreviousHitbox.AttackHitboxPlayer.remove_animation_library("sprites")
	%NextPreviousHitbox.AttackHitboxPlayer.add_animation_library("sprites", library)

func AddNewFrame(animation, time, value):
	var anim = library.get_animation(animation)
	
	for track in anim.get_track_count():
		if anim.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:disabled"):
			anim.track_insert_key(track, time, value)
		if anim.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D/DebugAttackBox:color"):
			anim.track_insert_key(track, time, Color8(219, 24, 78, 212))
