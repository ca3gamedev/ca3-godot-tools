extends Node

#ID of the attack on the animationTree
@export var attack_id : float = 0.1
#Time for the hitstop to last
@export var attack_hitstun : float = 1.0
#Strenght of the camera shake
@export var shake_strenght : float = 10.0
#Speed of the delta lerp to end up the shake (bigger number means shorter time of shake)
@export var shake_speed : float = 2.0

func UpdateAnim():
	pass

func Start():
	%Hitbox.hitstun = attack_hitstun
	%Hitbox.shakestrenght = shake_strenght
	%Hitbox.shake_speed = shake_speed
	%Anim.set("parameters/conditions/attack", true)
	%Anim.set("parameters/ATTACK/blend_position", attack_id * %Transitions.motion)
	%AttackBoxAnimTree.set("parameters/ATTACKS/blend_position", attack_id * %Transitions.motion)
