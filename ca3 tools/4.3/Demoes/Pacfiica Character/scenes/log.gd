extends Label

@onready var Transition = $"../Player/Transitions"

func _process(delta):
	self.text = str(Transition.rawmotion)
	%STATE.text = str(Transition.specialinput)
	%RAWSTATE.text = str(Transition.rawspecialinput)
