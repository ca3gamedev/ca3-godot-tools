extends Node

@export var attack_hitstun : float
@export var shake_strenght : float
@export var shake_speed : float
@export var attack_id : float
@export var distance_attack : float
@export var frame_attack : int

func Start():
	%Hitbox.hitstun = attack_hitstun
	%Hitbox.shakestrenght = shake_strenght
	%Hitbox.shake_speed = shake_speed
	$"../".Anim.set("parameters/conditions/attack", true)
	var dir = %AIMotion.player_angle
	$"../".Anim.set("parameters/ATTACK/blend_position", attack_id * dir)
	
	%Hitbox.get_node("CollisionShape2D").position = dir * distance_attack
	%Hitbox.get_node("CollisionShape2D").position = dir * distance_attack

func Update(delta):
	if frame_attack == $"../../".Sprites.get_node("Sprites/SpriteSheet").frame:
		$"../../Center/Hitbox/CollisionShape2D".disabled = false
	else:
		$"../../Center/Hitbox/CollisionShape2D".disabled = true
