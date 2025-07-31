extends Node

@export var close_enemies : Array[CharacterBody3D]
@export var closest : CharacterBody3D
@export var final_distance : float

func _ready():
	$Timer.start(randf_range(0.1, 0.5))


func _on_timer_timeout():

	%FSM.close_dir = Vector2.ZERO
	
	if close_enemies.size() > 1:
		var distance = 999999
		
		for i in close_enemies:
			var dist = i.global_position.distance_to($"../..".global_position)
			if dist < distance:
				distance = dist
				closest = i
		
		final_distance = distance
		
		if is_instance_valid(closest):
			var dir = (closest.global_position - $"../..".global_position).normalized()
			%FSM.close_dir = Vector2(dir.x, dir.z) * -1


func _on_near_perception_area_exited(area):
	
	if area.is_in_group("ENEMIES"):
		if is_instance_valid(area.get_parent().get_parent()):
			close_enemies.erase(area.get_parent().get_parent())
	

func _on_near_perception_area_entered(area):
	
	if area.is_in_group("ENEMIES"):
		if is_instance_valid(area.get_parent().get_parent()):
			close_enemies.append(area.get_parent().get_parent())
