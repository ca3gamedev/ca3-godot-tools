extends Node

@export var MouseBlock: bool




func _on_block_01_mouse_entered():
    MouseBlock = true


func _on_block_01_mouse_exited():
    MouseBlock = false
