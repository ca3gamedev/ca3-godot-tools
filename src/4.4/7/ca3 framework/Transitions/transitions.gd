extends Node

@export var Next : String

func Start():
	if Next != "null":
		Frame.StopLOG()
		$AnimationPlayer.play("Intro")

func End():
	$AnimationPlayer.play("End")

func _on_animation_player_animation_finished(anim_name):
	
	if anim_name == "Intro":
		if Next != "null" :
			get_tree().change_scene_to_file(Next)
			Next = "null"
		End()
	
	if anim_name == "End":
		if get_tree().get_root().get_node_or_null("Root") != null:
			get_tree().get_root().get_node("Root").UNPAUSE()
			Next = "null"
