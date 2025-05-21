extends Node2D

var speed = 300

@export var Camera : Camera2D

func _process(delta):
	
		if Input.is_action_pressed("LEFT"):
			Camera.position.x -= delta * speed
		if Input.is_action_pressed("RIGHT"):
			Camera.position.x += delta * speed
