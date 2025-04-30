extends Node

@onready var library = AnimationLibrary.new()

func NewAnimation(loop, pre_name, current_anim):
	var anim = Animation.new()
	anim.loop_mode = int(loop)
	anim.length = %NextPreviousFrame.AnimationPLayerSprites.get_animation(current_anim).length
	
	var frame_index2 = anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(frame_index2, "../Hitbox/fireball_spawn:position")
	anim.track_insert_key(frame_index2, 0.0, Vector2i(0, 0))
	anim.track_set_interpolation_type(frame_index2, 0)
	
	var frame_index3 = anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(frame_index3, "..:fireball_spawn")
	anim.track_insert_key(frame_index3, 0.0, false)
	anim.track_set_interpolation_type(frame_index3, 0)
	
	library.add_animation(pre_name, anim)
	if %NextPreviousHitbox.AttackHitboxPlayer.has_animation_library("sprites"):
		%NextPreviousHitbox.AttackHitboxPlayer.remove_animation_library("sprites")
	%NextPreviousHitbox.AttackHitboxPlayer.add_animation_library("sprites", library)

func AddNewFrame(animation, time, value):
	var anim = library.get_animation(animation)
	
	for track in anim.get_track_count():
		if anim.track_get_path(track) == NodePath("../Hitbox/CollisionShape2D:disabled"):
			anim.track_insert_key(track, time, value)
