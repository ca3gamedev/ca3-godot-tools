extends Timer

func _on_timeout():
	get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_INHERIT)


func _on_AIhitstop_freeze():
	$"../".call_deferred("set_process_mode", Node.PROCESS_MODE_INHERIT)
