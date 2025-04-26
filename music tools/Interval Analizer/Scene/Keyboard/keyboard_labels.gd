extends Node2D

@export var TrackOffset : int
@export var KeyOffset : int

@export var KeyboardLabel : PackedScene
@export var NumberofTracks : int

func ClearTracks():
	for i in %PianoRoll.get_node("Notes").get_children():
		i.queue_free()
	for i in %PianoRoll.get_node("ChordNotes").get_children():
		i.queue_free()
	for i in %PianoRoll.get_node("CanvasLayer/Chords").get_children():
		i.queue_free()

func AddTracks(value):
	var tmp = Node2D.new()
	tmp.name = value
	%PianoRoll.get_node("Notes").add_child(tmp)
	
