extends CharacterBody2D

@export var angle : Vector2
@export var speed : float
@export var PlayerID : int
@export var Is_AI : bool
@export var damage : int

func _physics_process(delta):
	var next = delta * angle * speed
	self.move_and_collide(next)


func _on_area_2d_area_entered(area):
	
	if area.is_in_group("ENEMY"):
		area.DAMAGE(damage)
