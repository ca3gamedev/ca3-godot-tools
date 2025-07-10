extends Node2D

var x = 1
var idle = true

@export var HP : int
@export var myname : String

func _ready():
	%P1HP.max_value = HP
	%P1HP.value = HP
	%P1Name.text = myname

func _process(delta):
	
	if idle:
		if %P1Motion.value > 2.5:
			if x > 0 and Input.is_action_just_released("LEFT"):
				x -= 1
				%P1Motion.value -= 2.5
			if x < %Enemy.x-1 and Input.is_action_just_released("RIGHT"):
				x += 1
				%P1Motion.value -= 2.5
		
		if Input.is_action_just_released("A") and %P1Motion.value > 9:
			%P1Motion.value -= 10
			idle = false
			$Sprites/Animations.play("sprites/KICK_FRONT_")
			
			if %Enemy.x == x+1:
				%Enemy.HIT()
		
	self.global_position = self.global_position.slerp(%Map.get_node(str(x)).global_position, delta * 2)
	%P1Motion.value += delta * 5


func _on_animations_animation_finished(anim_name):
	idle = true
	$Sprites/Animations.play("sprites/IDLE_FRONT_")

func HIT():
	idle = false
	$Sprites/Animations.play("sprites/Hurt_FRONT_")
	HP -= 10
	%P1HP.value = HP
