extends Node

@export var frame_label_scene : PackedScene
@export var keyframe_scene : PackedScene
@export var MyAnim : AnimationPlayer
var Xoffset = 20
var frames_lenght = 30
@export var Playlist : Node2D
var id = 0

func LOADANIMATIONS():
	var animations = MyAnim.get_animation_list()
	%AnimList.clear()
	for i in animations:
		%AnimList.add_item(i)


func _on_anim_list_item_selected(index):
	MyAnim.play(%AnimList.get_item_text(index))
	MyAnim.pause()
	frames_lenght = (MyAnim.current_animation_length / %GUI.frame_duration)
	
	id = index
	Update()
	

func Update():
	var old_frames = Playlist.get_children()
	for old in old_frames:
		if old.name != "Camera2D":
			old.queue_free()
	
	var anims = MyAnim.get_animation(%AnimList.get_item_text(id))
	for track in anims.get_track_count():
		var key_tmp = keyframe_scene.instantiate()
		key_tmp.get_node("Log").text = anims.track_get_path(track)
		key_tmp.position.x = 300 * track
		Playlist.add_child(key_tmp)
		for key in anims.track_get_key_count(track):
			var time = anims.track_get_key_time(track, key)
			key_tmp.get_node("ItemList").add_item(str(time))
		
	
