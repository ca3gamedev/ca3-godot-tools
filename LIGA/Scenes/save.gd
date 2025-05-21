extends Node

var map = []
var map_size = Vector2i.ZERO

func compress():
    var canvas = %Math.ClampV2(0 - ( %CanvasWidth.value / 2), 0 - ( %CanvasHeigth.value / 2))
    map_size = Vector2i( %CanvasWidth.value, %CanvasHeigth.value)

    map = []
    for x in %CanvasWidth.value:
        map.append([])
        for y in %CanvasHeigth.value:
            map[x].append([])
            map[x][y] = -1

    for x in %CanvasWidth.value:
        for y in %CanvasHeigth.value:
            if %UnderLayer.get_cell_source_id(Vector2i(x, y)) != -1:
                map[x][y] = %UnderLayer.get_cell_source_id(Vector2i(x, y))
            if %UnderMidLayer.get_cell_source_id(Vector2i(x, y)) != -1:
                map[x][y] = %UnderMidLayer.get_cell_source_id(Vector2i(x, y))
            if %MiddleLayer.get_cell_source_id(Vector2i(x, y)) != -1:
                map[x][y] = %MiddleLayer.get_cell_source_id(Vector2i(x, y))
            if %UpperMidLayer.get_cell_source_id(Vector2i(x, y)) != -1:
                map[x][y] = %UpperMidLayer.get_cell_source_id(Vector2i(x, y))
            if %UpperLayer.get_cell_source_id(Vector2i(x, y)) != -1:
                map[x][y] = %UpperLayer.get_cell_source_id(Vector2i(x, y))

func Save():
    var file = FileAccess.open("res://little_map.json", FileAccess.WRITE)

    var json_string = JSON.stringify(map)
    var json_size = JSON.stringify(map_size)

    file.store_line(json_size)
    file.store_line(json_string)

    %LOG.text = "SAVED TO : " + str(ProjectSettings.globalize_path("res://")) + "/little_map.json"


func _on_export_pressed():
    compress()
    Save()
