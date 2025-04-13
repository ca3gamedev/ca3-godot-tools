extends AnimationTree

func _ready():
	self.active = true

func _on_animation_finished(anim_name):
	$"../".EndAnim()
