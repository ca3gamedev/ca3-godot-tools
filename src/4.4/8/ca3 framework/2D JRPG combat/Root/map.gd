extends Node2D

@export var tile : PackedScene
@export var off_x : int


func _ready():
	
	for i in 6:
		var tmp = tile.instantiate()
		tmp.position.x = i * off_x
		tmp.name = str(i)
		add_child(tmp)
	
	%Player.global_position = get_node("1").global_position
