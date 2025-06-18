extends Node2D

@export var Next : String

func _on_start_timeout():
	$Video.play()


func _on_video_finished():
	
	Transitions.Next = SceneDirectory.GetScreen(Next)
	Transitions.Start()
