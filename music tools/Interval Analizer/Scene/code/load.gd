extends Node

@export var begin_time : int
@export var last_time : int
@export var zoom : int
@onready var Utilities = load("res://addons/midi/Utility.gd")
@export var chord_min_time : int

var notes = []
var chords = []
var current_position_begin = 0
var current_position = 0
var non_empty_track = []
var channels = []
var names = []

const MIDI_MESSAGE_META = 0xFF
const MIDI_META_TRACK_NAME = 0x03

func _on_load_pressed():
	%LOADDialog.show()

func LOAD():
	%MidiPlayer.play(0.0)
	%MidiPlayer.stop()
	
	%KeyboardLabels.ClearTracks()
	
	%PianoRoll.origin = %KeyboardLabels.get_node("TEST").global_position
	%PianoRoll.zoom = zoom
	var last_on : int = 0
	current_position = 0
	notes = []
	chords = []
	non_empty_track = []
	AddChannels()
	%PianoRoll.ClearInteractiveGhostList()
	
	for track in %MidiPlayer.smf_data.tracks:
		for event in track.events:
			if event.event is SMF.MIDIEventNoteOn:
				last_on = event.time
				AddNote(event.event.note)
				current_position_begin = event.time
				%PianoRoll.AddChordLabel(event.time, GetNotesChords())
			elif event.event is SMF.MIDIEventNoteOff:
				last_time = event.time
				%PianoRoll.AddNote(event.channel_number, last_on, event.event.note % 12, event.time - last_on)
				AddOff(event.event.note, event.time)
				RemoveKeys()
				if event.time > current_position:
					current_position = event.time
	%TrackVertical.max_value = last_time + (20 * zoom)
	
	for i in %ChannelTracks.item_count:
		var color = %PianoRoll.colors[int(%ChannelTracks.get_item_text(i))]
		%ChannelTracks.set_item_custom_bg_color(i, color)
	%PianoRoll.UpdateGhostChords()


func AddChannels():
	%ChannelTracks.clear()
	%TrackName.clear()
	channels = []
	names = []
	var last_channel_number = 0
	for track in %MidiPlayer.smf_data.tracks:
		for event in track.events:
			if event.event is SMF.MIDIEventNoteOn or event.event is SMF.MIDIEventNoteOff:
				if not channels.has(event.channel_number):
					channels.append(event.channel_number)
					last_channel_number = int(event.channel_number)
			if event.event.type is SMF.MIDIEventType:
				if event.event.type == SMF.MIDIEventType.system_event:
					if event.event.args.type == 3:
						var new_name = event.event.args.text
						
						var contains = false
						for i in names:
							if i[0] == new_name:
								contains = true
						if not contains:
							names.append([new_name, last_channel_number])
	
	for i in len(channels):
		%ChannelTracks.add_item(str(channels[i]))
		%KeyboardLabels.AddTracks(str(channels[i]))
	for i in len(names):
		%TrackName.add_item(str(names[i][1]) + " : " + str(names[i][0]))


func AddChord(begin_time, end_time, new_chord, keys):
	if new_chord == null:
		return
	else:
		chords.append([])
		#BEGIN TIME = 0
		chords[chords.size()-1].append(begin_time)
		#END TIME = 1
		chords[chords.size()-1].append(end_time)
		#CHORD NAMES = 2
		chords[chords.size()-1].append(new_chord)
		#CHORD KEY ARRAY = 3
		chords[chords.size()-1].append(keys)

func GetNotesChords():
	var chord_notes = []
	for i in notes:
		chord_notes.append(i[0])
	return chord_notes

func AddNote(key):
	# Only add the note if it doesn't already exist
	for note in notes:
		if note[0] == key:
			return
	notes.append([key, current_position, 0])

func AddNote2(key):
	for i in notes:
		if i[0] == key:
			if i[1] < current_position:
				i[1] = current_position
			return
	notes.append([])
	#KEY == 0
	notes[notes.size()-1].append(key)
	#TIME BEGIN == 1
	notes[notes.size()-1].append(0)
	#TIME END == 2
	notes[notes.size()-1].append(0)

func AddOff(key, time):
	for i in notes:
		if i[0] == key:
			i[2] = time

func RemoveKeys():
	for i in range(notes.size() - 1, -1, -1):
		if notes[i][2] != 0 and notes[i][2] < current_position:
			notes.remove_at(i)


func _on_load_dialog_file_selected(path):
	
	%MidiPlayer.file = path
	
	if %MidiPlayer.file == "":
		%LOG.text = "There's not current midi file LOADED"
	if %MidiPlayer.soundfont == "":
		%LOG.text = "There's not current soundfont (.sf2) LOADED"
	
	if %MidiPlayer.file != "" and %MidiPlayer.soundfont != "":
		%LOG.text = "Trying to load midi"
		LOAD()
		%LOG.text = "Midi loaded!!!"


func _on_loadsf_2_dialog_file_selected(path):
	
	%MidiPlayer.soundfont = path
	
	if %MidiPlayer.file == "":
		%LOG.text = "There's not current midi file LOADED"
	if %MidiPlayer.soundfont == "":
		%LOG.text = "There's not current soundfont (.sf2) LOADED"
	
	if %MidiPlayer.file != "" and %MidiPlayer.soundfont != "":
		%LOG.text = "Trying to load midi"
		LOAD()
		%LOG.text = "Midi loaded!!!"


func _on_loadsf_2_pressed():
	%LOADSF2Dialog.show()
