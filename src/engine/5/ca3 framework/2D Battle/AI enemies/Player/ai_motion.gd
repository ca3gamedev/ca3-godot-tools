extends Node

@export var speed_walk : float
@export var speed_dash : float

# default speed walk is too small for move_and_slide
@export var multiplier : float

@export var Root : CharacterBody2D
@export var motion : Vector2
var player_angle = Vector2.DOWN
