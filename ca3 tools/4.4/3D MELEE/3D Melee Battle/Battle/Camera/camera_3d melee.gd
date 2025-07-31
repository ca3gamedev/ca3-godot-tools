extends Camera3D

func _process(delta):
	
	$"../".global_position = $"../".global_position.slerp(Variables.Player3D.global_position, delta * 4)
