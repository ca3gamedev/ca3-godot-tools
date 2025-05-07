extends AnimationTree

@export var is_AI : bool

func _ready():
	self.active = true

func _on_animation_finished(anim_name):
	
	if is_AI:
		$"../".EndAIAnim()
	else:
		$"../".EndAnim()
