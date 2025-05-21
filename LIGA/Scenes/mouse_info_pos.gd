extends Node

var pos = Vector2i.ZERO

func _process(delta):

    var mouse_pos = %"UnderLayer".get_local_mouse_position()

    pos = %"UnderLayer".local_to_map(mouse_pos)
    %MousePosX.text = str(pos.x)
    %MousePosY.text = str(pos.y)
