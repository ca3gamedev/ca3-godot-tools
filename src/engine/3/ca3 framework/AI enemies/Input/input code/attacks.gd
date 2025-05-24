extends Node

@export var should_attack : bool
@export var Transition : Node
@export var delay_active : int
@export var delay_time : float

func _ready():
	$"../Attack".start(1)
	delay_active = randf_range(0.5, 3)
	$"../AIDelay".start(delay_active)

func Update():
	if should_attack and delay_active == 1:
		should_attack = false
		Transition.ChangeState("PUNCH")


func _on_attack_timeout():
	should_attack = true
	$"../Attack".start(randf_range(0.2, 1.5))


func _on_ai_delay_timeout():
	$"../AIDelay".start(delay_active)
	delay_active += 1
	if delay_active > 2:
		delay_active = 0
