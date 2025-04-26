extends Node

@export var chord_type : int
@export var current_note : int

func _process(delta):
	
	if Input.is_action_just_released("C"):
		current_note = 0
		%PianoRoll.ViewChordGhost(0, chord_type)
	if Input.is_action_just_released("Cs"):
		current_note = 1
		%PianoRoll.ViewChordGhost(1, chord_type)
	if Input.is_action_just_released("D"):
		current_note = 2
		%PianoRoll.ViewChordGhost(2, chord_type)
	if Input.is_action_just_released("Ds"):
		current_note = 3
		%PianoRoll.ViewChordGhost(3, chord_type)
	if Input.is_action_just_released("E"):
		current_note = 4
		%PianoRoll.ViewChordGhost(4, chord_type)
	if Input.is_action_just_released("F"):
		current_note = 5
		%PianoRoll.ViewChordGhost(5, chord_type)
	if Input.is_action_just_released("Fs"):
		current_note = 6
		%PianoRoll.ViewChordGhost(6, chord_type)
	if Input.is_action_just_released("G"):
		current_note = 7
		%PianoRoll.ViewChordGhost(7, chord_type)
	if Input.is_action_just_released("Gs"):
		current_note = 8
		%PianoRoll.ViewChordGhost(8, chord_type)
	if Input.is_action_just_released("A"):
		current_note = 9
		%PianoRoll.ViewChordGhost(9, chord_type)
	if Input.is_action_just_released("As"):
		current_note = 10
		%PianoRoll.ViewChordGhost(10, chord_type)
	if Input.is_action_just_released("B"):
		current_note = 11
		%PianoRoll.ViewChordGhost(11, chord_type)
	
	if Input.is_action_just_released("Seven"):
		chord_type = 0
		%ChordType.text = "Seventh Chords Selected"
		%PianoRoll.ViewChordGhost(current_note, chord_type)
	if Input.is_action_just_released("Major"):
		chord_type = 1
		%ChordType.text = "Major Chords Selected"
		%PianoRoll.ViewChordGhost(current_note, chord_type)
	if Input.is_action_just_released("Minor"):
		chord_type = 2
		%ChordType.text = "Minor Chords Selected"
		%PianoRoll.ViewChordGhost(current_note, chord_type)
	if Input.is_action_just_released("Dis"):
		chord_type = 3
		%ChordType.text = "Disminished Chords Selected"
		%PianoRoll.ViewChordGhost(current_note, chord_type)
	if Input.is_action_just_released("Aum"):
		chord_type = 4
		%ChordType.text = "Aumented Chords Selected"
		%PianoRoll.ViewChordGhost(current_note, chord_type)
	if Input.is_action_just_released("Sus2"):
		chord_type = 5
		%ChordType.text = "Suspended 4 Chords Selected"
		%PianoRoll.ViewChordGhost(current_note, chord_type)
	if Input.is_action_just_released("Sus4"):
		chord_type = 6
		%ChordType.text = "Suspended 6 Chords Selected"
		%PianoRoll.ViewChordGhost(current_note, chord_type)
