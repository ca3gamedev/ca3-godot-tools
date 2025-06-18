extends Node

func _ready():
	Start()

func Start():
	$AnimationPlayer.play("End")

func End():
	$AnimationPlayer.play("Intro")

func _on_animation_player_animation_finished(anim_name):
	
	if anim_name == "End":
		if get_tree().get_root().get_node_or_null("Root") != null:
			get_tree().get_root().get_node("Root").UNPAUSE()
	
	if anim_name == "Intro":
		VariableNodes.ResetBattle()
