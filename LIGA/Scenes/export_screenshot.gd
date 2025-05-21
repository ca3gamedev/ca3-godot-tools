extends Node

@export var offset: Vector2
@export var size_offset: Vector2


func _process(delta):

    if Input.is_action_just_released("SCREENSHOT"):

        var posi = Vector2i()
        posi.x = 1 - ( %CanvasWidth.value / 2)
        posi.y = 1 - ( %CanvasHeigth.value / 2)

        var posl = %UnderLayer.map_to_local(posi)
        var pos = %UnderLayer.to_global(posl)
        pos += offset

        var sizei = Vector2()
        sizei.x = %CanvasWidth.value - 1
        sizei.y = %CanvasHeigth.value - 1

        var sizel = %UnderLayer.map_to_local(sizei)
        var size = %UnderLayer.to_global(sizel)
        size += size_offset

        var canvas = Rect2(pos, size)

        %GUI.hide()

        var image = get_viewport().get_texture().get_image().get_region(canvas)

        var path = "res://little_map.png"
        %LOG.text = "SAVED TO : " + str(ProjectSettings.globalize_path("res://")) + " /little_map.png"
        image.save_png(path)

        %GUI.show()
