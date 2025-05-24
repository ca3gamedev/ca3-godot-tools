extends Node

var frame = 0


func _on_frames_item_selected(index):
	frame = index
	
	%Load.animatedsprites.frame = frame
	%Mouse.UpdateHitboxes()
