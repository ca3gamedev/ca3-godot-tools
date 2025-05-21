extends Node

@export var MyCamera2D : Camera2D
@export var PlayerBulletManager : Node2D
@export var EnemyBulletManager : Node2D

@export var Player1 : CharacterBody2D

@export var score : int

func ADDSCORE(new_score):
	score -= new_score
	get_tree().get_root().get_node("Root/CanvasLayer/LOG").value = score
