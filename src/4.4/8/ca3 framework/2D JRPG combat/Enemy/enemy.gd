extends Node2D

@export var x = 4
var hit = false
@export var HP : int
@export var myname : String

func _ready():
	%P2HP.max_value = HP
	%P2HP.value = HP
	%P2Name.text = myname
	self.global_position = %Map.get_node(str(x)).global_position
	$ATTACK.start(randf_range(0.5, 3))

func _process(delta):
	self.global_position = self.global_position.slerp(%Map.get_node(str(x)).global_position, delta * 2)


func _on_walk_timeout():
	
	if hit:
		return
	
	if randi_range(0, 5) == 2:
		if randi_range(0, 10) > 5:
			if x < 5:
				x += 1
		else:
			if x > %Player.x + 1:
				x -= 1


func _on_attack_timeout():
	$ATTACK.start(randf_range(0.5, 3))
	if hit:
		return
	$Sprites/Animations.play("sprites/KICK_FRONT_")
	if %Player.x == x-1:
		%Player.HIT()


func _on_animations_animation_finished(anim_name):
	hit = false
	$Sprites/Animations.play("sprites/IDLE_FRONT_")


func HIT():
	hit = true
	$Sprites/Animations.play("sprites/Hurt_FRONT_")
	HP -= 10
	%P2HP.value = HP
