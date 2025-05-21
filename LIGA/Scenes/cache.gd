extends Node

var saved_id = 0

func _ready():
    %Cache.hide()

func SaveCache():
    saved_id = %LAYERS.current_layer

    match (saved_id):
        0: %Cache.tile_map_data = %UnderLayer.tile_map_data
        1: %Cache.tile_map_data = %UnderMidLayer.tile_map_data
        2: %Cache.tile_map_data = %MiddleLayer.tile_map_data
        3: %Cache.tile_map_data = %UpperMidLayer.tile_map_data
        4: %Cache.tile_map_data = %UpperLayer.tile_map_data

    %UNDO.disabled = false

func _process(delta):
    if Input.is_action_just_released("UNDO"):
        if %UNDO.disabled == false:
            Undo()

func Undo():

    match (saved_id):
        0: %UnderLayer.tile_map_data = %Cache.tile_map_data
        1: %UnderMidLayer.tile_map_data = %Cache.tile_map_data
        2: %MiddleLayer.tile_map_data = %Cache.tile_map_data
        3: %UpperMidLayer.tile_map_data = %Cache.tile_map_data
        4: %UpperLayer.tile_map_data = %Cache.tile_map_data


    %Cache.clear()
    %UNDO.disabled = true


func _on_undo_pressed():
    Undo()
