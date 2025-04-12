extends Node2D


func _on_animation_tree_mapper_pressed():
	get_tree().change_scene_to_file("res://Scenes/root.tscn")


func _on_hitbox_generator_pressed():
	get_tree().change_scene_to_file("res://Scenes/Hitbox Editor/hit_box_root.tscn")
