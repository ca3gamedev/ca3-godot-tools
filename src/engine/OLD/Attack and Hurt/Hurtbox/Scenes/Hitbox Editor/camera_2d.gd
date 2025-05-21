extends Camera2D

@export var origin : Vector2i
@export var newoffset : Vector2i

func _ready():
	origin = self.global_position


func _on_hzoom_value_changed(value):
	newoffset.x = value
	self.global_position = origin + newoffset

func _on_vzoom_value_changed(value):
	newoffset.y = value
	self.global_position = origin + newoffset
