extends Node3D

@export var level : int
@export var enemy01 : PackedScene

func _ready():
	
	for i in level:
		var tmp = enemy01.instantiate()
		add_child(tmp)
		var x = randf_range(%TOPLEFT.global_position.x, %BOTTOMRIGHT.global_position.x)
		var y = randf_range(%TOPLEFT.global_position.z, %BOTTOMRIGHT.global_position.z)
		tmp.global_position = Vector3(x, 0, y)
