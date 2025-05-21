extends Node

func _ready():
    UpdateCursor()
    $"../../OriginWorld".global_position = %"UnderLayer".to_global( %"UnderLayer".map_to_local(Vector2i.ZERO))

func UpdateCursor():
    var pos = Vector2i.ZERO
    pos.x = %Math.ClampX( %OFFSETX.value)
    pos.y = %Math.ClampY( %OFFSETY.value)
    %OriginCursor.global_position = %"UnderLayer".to_global( %"UnderLayer".map_to_local(pos))


func _on_offsetx_value_changed(value):
    %OFFSETX.value = %Math.ClampX( %OFFSETX.value)
    UpdateCursor()


func _on_offsety_value_changed(value):
    %OFFSETY.value = %Math.ClampY( %OFFSETY.value)
    UpdateCursor()
