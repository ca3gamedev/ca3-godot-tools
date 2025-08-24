extends Camera3D

@export var Player : CharacterBody3D

func _physics_process(delta: float) -> void:
	
	self.global_position.x = lerp(self.global_position.x, Player.global_position.x, delta * 2)
