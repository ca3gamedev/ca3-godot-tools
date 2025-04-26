extends Node2D

@export var note : PackedScene
@export var origin : Vector2i
@export var offset_y : int
@export var zoom : int
@export var chord_color : Color
@export var fifth_note : Color
@export var root_note : Color
@export var chord_off_x : int
@export var last_chord_name : String
@export var roots = []
@export var current_notes_chord = []
@export var interactive_ghosts : bool
@export var interactive_ghost_id : int
@export var colors : Array[Color]

func _ready():
	$Current_Time.size.x = 13 * 20
	$Current_Time.position.y = 0
	$Current_Time.size.y = 10
	%Root.color = root_note
	%Fifth.color = fifth_note
	%Other.color = chord_color
	AddChordGhost()

func ClearInteractiveGhostList():
	current_notes_chord = []
	interactive_ghost_id = 0


func _process(delta):	
	
	if len(current_notes_chord) > 0 and interactive_ghost_id < len(current_notes_chord)-1:
		if interactive_ghosts and current_notes_chord[interactive_ghost_id][1] < %MidiPlayer.position:
			%CURRENTCHORD.text = str(current_notes_chord[interactive_ghost_id][2])
			UpdateInteractiveChordGhost(current_notes_chord[interactive_ghost_id])
			interactive_ghost_id += 1
		%Circle.UpdateCircle(str(current_notes_chord[interactive_ghost_id][2]))

func UpdateGhostChords():
	%Circle.UpdateCircle(str(current_notes_chord[interactive_ghost_id][2]))
	UpdateInteractiveChordGhost(current_notes_chord[interactive_ghost_id])
	%CURRENTCHORD.text = str(current_notes_chord[interactive_ghost_id][2])

func UpdateGhosts():
	if interactive_ghosts:
		%InteractiveGhosts.show()
	else:
		%InteractiveGhosts.hide()

func UpdateInteractiveChordGhost(keys):
	
	for i in %InteractiveGhosts.get_child_count():
		%InteractiveGhosts.get_child(i).hide()
		%InteractiveGhosts.get_child(i).color = chord_color
	
	var keys_alone = keys[0]
		
	for i in len(keys_alone):
		var note = keys_alone[i]
		var nkey = note%12
		for x in %InteractiveGhosts.get_children():
			if x.name == str(nkey):
				x.show()
				if i == 0:
					x.color = root_note
				if i == 2:
					x.color = fifth_note


func ViewChordGhost(notes, chordtype):
	for i in %Chords.get_child_count():
		%Chords.get_child(i).hide()
		%Chords.get_child(i).color = chord_color
	
	var keys = GetKeys(notes, chordtype)
	for i in len(keys):
		%Chords.get_child(keys[i]).show()
		if i == 0:
			%Chords.get_child(keys[i]).color = root_note
		if i == 2:
			%Chords.get_child(keys[i]).color = fifth_note


func AddNote(track, time, key, duration):
	var tmp = note.instantiate()
	var x = origin.x + (key * 20) - 20
	var y = (time + origin.y + offset_y) / zoom
	tmp.global_position = Vector2i(x, y)
	tmp.size.x = 15
	tmp.size.y = duration / zoom
	var i = 255 / 20
	tmp.color = colors[track]
	$Notes.get_node(str(track)).add_child(tmp)

func AddChord(begin_time, keys):
	var sorted = get_sorted_chord_notes(keys)
	var chord_name = GetChordName(keys)
	current_notes_chord.append([sorted, begin_time, chord_name])

func AddChordLabel(begin_time, keys):
	
	var new_name = GetChordName(keys)
	if new_name == "Unknown chord" or new_name == last_chord_name:
		return
	AddChord(begin_time, keys)
	last_chord_name = new_name
	var key = chord_name_to_root_int(new_name)
	roots.insert(0, [key, begin_time])
	
	var tmp = Label.new()
	var x = origin.x + 250
	var y = (begin_time + origin.y + offset_y) / zoom
	tmp.global_position = Vector2i(x, y)
	tmp.text = last_chord_name
	$ChordNotes.add_child(tmp)
	
	if len(roots) > 2:
		var interval = Label.new()
		x = origin.x + 400
		y = (begin_time + origin.y + offset_y) / zoom
		interval.global_position = Vector2i(x, y)
		interval.text = get_interval_label(roots[1][0], roots[0][0])
		$ChordNotes.add_child(interval)

	

func AddChordGhost():
	for i in 12:
		var tmp = note.instantiate()
		var x = origin.x + (i * 20) + 20
		var y = (origin.y + offset_y) / zoom
		tmp.global_position = Vector2i(x, y)
		tmp.size.x = 15
		tmp.size.y = 500 / (zoom / 10)
		tmp.color = chord_color
		tmp.name = str(i)
		tmp.hide()
		%Chords.add_child(tmp)
		
		var tmp2 = note.instantiate()
		tmp2.global_position = Vector2i(x, y)
		tmp2.size.x = 15
		tmp2.size.y = 300 / (zoom / 10)
		tmp2.color = chord_color
		tmp2.name = str(i)
		tmp2.hide()
		%InteractiveGhosts.add_child(tmp2)


func GetYOrigin():
	return origin.y + offset_y

func SetTime(value):
	$Current_Time.position.y = value / zoom

func GetTimeY():
	return $Current_Time.position.y

func SetPosY(value):
	self.global_position.y = value

func HideAllTrack():
	for i in $Notes.get_child_count():
		$Notes.get_child(i).hide()
	for i in %Chords.get_child_count():
		%Chords.get_child(i).hide()

func ShowTrack(index):
	$Notes.get_child(index).show()

func HideTrack(index):
	$Notes.get_child(index).hide()

func ShowAllTrack():
	for i in $Notes.get_child_count():
		$Notes.get_child(i).show()

func GetKeys(root_note: int, chord_type: int) -> Array:
	var root = root_note % 12  # Map 1-12 to 0-11
	
	var chord_formulas = {
		0: [0, 4, 7, 10],  # Seventh (Dominant 7)
		1: [0, 4, 7],      # Major
		2: [0, 3, 7],      # Minor
		3: [0, 3, 6],      # Diminished
		4: [0, 4, 8],      # Augmented
		5: [0, 5, 7],      # Suspended 4
		6: [0, 2, 7]       # Suspended 6
	}
	
	var intervals = chord_formulas.get(chord_type, [])
	var notes = []

	for interval in intervals:
		notes.append((root + interval) % 12)

	return notes

func GetChordName(notes):
	
	var sorted = []
	for i in notes:
		sorted.append(i%12)
	
	return identify_chord(sorted)

func identify_chord(notes: Array) -> String:
	var note_names = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
	var chord_types = {
		[0, 4, 7]: "Major",
		[0, 3, 7]: "Minor",
		[0, 4, 7, 10]: "7",
		[0, 3, 6]: "Diminished",
		[0, 4, 8]: "Augmented",
		[0, 5, 7]: "Sus4",
		[0, 2, 7]: "Sus2",
		[0, 3, 7, 10]: "Minor 7",
		[0, 3, 6, 10]: "Diminished 7"
	}
	
	# Try all rotations of the input as root
	for i in range(notes.size()):
		var root = notes[i]
		var intervals = []
		for j in range(notes.size()):
			var interval = (notes[j] - root + 12) % 12
			intervals.append(interval)
		intervals.sort()
		
		for formula in chord_types.keys():
			if intervals == formula:
				return "%s %s" % [note_names[root], chord_types[formula]]
	
	return "Unknown chord"


func get_chord_notes(notes: Array):
	var note_names = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
	var chord_types = {
		[0, 4, 7]: "Major",
		[0, 3, 7]: "Minor",
		[0, 4, 7, 10]: "7",
		[0, 3, 6]: "Diminished",
		[0, 4, 8]: "Augmented",
		[0, 5, 7]: "Sus4",
		[0, 2, 7]: "Sus2",
		[0, 3, 7, 10]: "Minor 7",
		[0, 3, 6, 10]: "Diminished 7"
	}
	
	# Try all rotations of the input as root
	for i in range(notes.size()):
		var root = notes[i]
		var intervals = []
		for j in range(notes.size()):
			var interval = (notes[j] - root + 12) % 12
			intervals.append(interval)
		intervals.sort()
		
		for formula in chord_types.keys():
			if intervals == formula:
				var sorted = formula
				return formula
	
	return "Unknown chord"



func get_interval_label(prev_root: int, current_root: int) -> String:
	var interval_names = {
		0: "Unison",
		1: "Minor 2nd",
		2: "Major 2nd",
		3: "Minor 3rd",
		4: "Major 3rd",
		5: "Perfect 4th",
		6: "Tritone",
		7: "Perfect 5th",
		8: "Minor 6th",
		9: "Major 6th",
		10: "Minor 7th",
		11: "Major 7th"
	}
	
	if prev_root == current_root:
		return "Unison"
	
	var ascending = (current_root - prev_root + 12) % 12
	var descending = (prev_root - current_root + 12) % 12
	
	if ascending <= descending:
		return "Ascending %s" % interval_names.get(ascending, "Unknown interval")
	else:
		return "Descending %s" % interval_names.get(descending, "Unknown interval")

func chord_name_to_root_int(chord_name: String) -> int:
	var note_to_int = {
		"C": 0, "C#": 1, "D": 2, "D#": 3, "E": 4, "F": 5,
		"F#": 6, "G": 7, "G#": 8, "A": 9, "A#": 10, "B": 11
	}

	# Split the chord name to extract the root (e.g., "C#", "D", etc.)
	var parts = chord_name.split(" ")
	if parts.size() == 0:
		return -1  # Invalid input
	
	var root_name = parts[0]
	
	# Return the integer or -1 if not found
	return note_to_int.get(root_name, -1)

func get_sorted_chord_notes(notes: Array) -> Array:
	if notes.size() < 2:
		return notes.duplicate() # not enough info to sort
	
	var best_fit = null
	var best_score = -1
	var best_sorted = []
	
	for i in range(notes.size()):
		var root = notes[i]
		var intervals = []
		var note_map = {}
		
		for note in notes:
			var interval = (note - root + 12) % 12
			intervals.append(interval)
			note_map[interval] = note
		
		intervals.sort()
		
		# Score based on how closely this matches common chord structures
		var score = 0
		if 4 in intervals or 3 in intervals:
			score += 2  # major or minor third
		if 7 in intervals:
			score += 2  # perfect fifth
		if 10 in intervals or 11 in intervals:
			score += 1  # minor or major 7th
		if 6 in intervals:
			score += 1  # diminished fifth
		if 8 in intervals:
			score += 1  # augmented fifth

		if score > best_score:
			best_score = score
			best_fit = root
			var sorted = []
			for interval in intervals:
				sorted.append(note_map[interval])
			best_sorted = sorted
	
	return best_sorted
