extends Node

@export var MyCamera2D : Camera2D
@export var PlayerBulletManager : Node2D
@export var EnemyBulletManager : Node2D

@export var Player1 : CharacterBody2D

@export var HP : int

@export var GUI : Node2D

func DAMAGE(new_hp):
	HP -= new_hp
	print(HP)
	GUI.CHANGEHP()
