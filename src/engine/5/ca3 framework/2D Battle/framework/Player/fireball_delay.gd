extends Timer

@export var idle : bool
var fireballshoot = 0


func _on_timeout():
	idle = true
