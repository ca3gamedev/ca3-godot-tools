extends Node


func _on_open_pressed():
	%FileOpen.show()


func _on_file_open_file_selected(path):
	
	var scene = ResourceLoader.load(path)
	var tmp = scene.instantiate()
	%Character.add_child(tmp)
