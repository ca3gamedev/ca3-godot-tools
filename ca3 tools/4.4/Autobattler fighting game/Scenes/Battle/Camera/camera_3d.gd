extends Camera3D

@export var speed : float

func _physics_process(delta: float) -> void:
	
	var dir = 0
	if Input.is_action_pressed("LEFT") and not Input.is_action_pressed("RIGHT"):
		dir = -1
	if Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT"):
		dir = 1
	
	self.position.x += dir * delta * speed
