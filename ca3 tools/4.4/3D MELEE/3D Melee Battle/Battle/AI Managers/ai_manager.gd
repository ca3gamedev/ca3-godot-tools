extends Node

@export var radius : float
var enemies = []
var rotation_angle = 0.0

func _process(delta):
	rotation_angle += delta * 0.2

func Sort():
	enemies = $"../Enemies".get_children()
	var id = 0
	var tier_id = 1
	for i in enemies.size():
		id += 1
		if id > 9:
			id = 0
			tier_id += 1
		if id % 3 == 1:
			enemies[i].wavy = true
		else:
			enemies[i].wavy = false
	
		var radio = radius * tier_id + 5
		var rot = rotation_angle + (id * 30)
		if tier_id == 2:
			rot *= -1
		var x = radio * cos(rot)
		var y = radio * sin(rot)
		enemies[i].target = Vector2(x, y)


func _on_sort_timer_timeout():
	Sort()
