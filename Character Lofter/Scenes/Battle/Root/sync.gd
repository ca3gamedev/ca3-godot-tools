extends Button

@export var Root3D : Node3D
@export var Root2D : Node2D
	

func Sync():
	Root3D.vertices = Root2D.get_node("Control").vertices
	Root3D.edges = Root2D.get_node("Control").edges
	Root3D.GetSliceMesh()


func _on_pressed():
	Sync()
