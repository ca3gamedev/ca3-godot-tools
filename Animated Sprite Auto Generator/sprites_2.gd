extends Node2D

## this script generates the animationlibrary and add the frames based
## on looking up each png on the animatedSprite

func AddFrames():
	var library = AnimationLibrary.new()
	for i in %AnimationPlayerList.item_count:
		var anim =  Animation.new()
		anim.loop = true
		var frame_count = $"../SpriteSheet".sprite_frames.get_frame_count(%AnimationPlayerList.get_item_text(i))
		anim.length = frame_count * 0.2
		var frame_index = anim.add_track(Animation.TYPE_VALUE)
		anim.track_set_path(frame_index, "Sprites/SpriteSheet:frame")
		
		for frame_id in range(frame_count):
			var time : float = frame_id / float(frame_count) * frame_count * 0.2
			anim.track_insert_key(frame_index, time, frame_id)
		
		var anim_name = anim.add_track(Animation.TYPE_VALUE)
		anim.track_set_path(anim_name, "Sprites/SpriteSheet:animation")
		anim.track_insert_key(anim_name, 0.0, %AnimationPlayerList.get_item_text(i))
		
		library.add_animation(%AnimationPlayerList.get_item_text(i), anim)
		
	## Sprites is just a generic name for the library
	if %Animations.has_animation_library("sprites"):
		%Animations.remove_animation_library("sprites")
	%Animations.add_animation_library("sprites", library)
