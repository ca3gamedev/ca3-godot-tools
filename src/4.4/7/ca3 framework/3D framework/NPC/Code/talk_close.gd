extends Area3D


func _on_body_exited(body):
	if body.is_in_group("PLAYER"):
		$"../".near = false
		$"../Dialog".hide()

func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		$"../".near = true
		$"../Dialog".show()
