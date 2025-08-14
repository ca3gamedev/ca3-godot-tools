extends CharacterBody3D

func _ready():
	Variables.Player3D = self



func GetPos(radius, angle):
	$TargetParent/Target.position = Vector3(0, 0, radius)
	$TargetParent.rotation.y = deg_to_rad(angle)
	var pos = $TargetParent/Target.global_position
	pos.z -= 4
	return pos


func GetTarget(radius, angle):
	return GetPos(radius + randf_range(1.0, 3.0), angle)


func _on_hitstop_timeout():
	self.process_mode = Node.PROCESS_MODE_INHERIT
