extends CharacterBody2D

@export var angle : Vector2
@export var speed : float
@export var PlayerID : int
@export var Is_AI : bool
@export var Is_Healing_Enemy : bool
@export var damage : int
@export var Is_Necromancer : bool
var target
var TeamID
@export var Fireball : Sprite2D

func _ready():
	
	if Is_AI:
		speed = (VariableNodes.Level / 3) * 30 + 50
		angle = (target.global_position - self.global_position).normalized()
	if Is_Healing_Enemy:
		speed = (VariableNodes.Level / 3) * 10 + 10
	if Is_Necromancer:
		speed = (VariableNodes.Level / 3) * 30 + 50
		angle = (target.global_position - self.global_position).normalized()


func Recolor():
	if Fireball != null:
		if TeamID == 0:
			Fireball.modulate = Color.BLUE
		else:
			Fireball.modulate = Color.RED
	else:
		if TeamID == 0:
			$ColorRect.modulate = Color.BLUE
		else:
			$ColorRect.modulate = Color.RED

func _physics_process(delta):
	var next = delta * angle * speed
	self.move_and_collide(next)


func _on_area_2d_area_entered(area):
	if area.is_in_group("ENEMY"):
		Music.Slash() 
		area.get_node("../").DAMAGE(damage)
	
	if area.is_in_group("AUTOBATTLER"):
		if area.get_parent().TeamID != TeamID:
			Music.Slash() 
			area.get_node("../").DAMAGE(damage)
	
	if area.is_in_group("WALL"):
		self.queue_free()
	
func _on_auto_delete_timeout():
	self.queue_free()


func _on_timer_timeout():
	var pos = self.global_position
	VariableNodes.AIDirector.NecroSpawn(pos.x, pos.y)
	self.queue_free()
