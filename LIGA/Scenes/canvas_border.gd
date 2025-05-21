extends Node

@export var width: int
@export var height: int
@export var pos: Vector2i


func _ready():
    width = %CanvasWidth.value
    height = %CanvasHeigth.value
    %CanvasBorder.clear()
    Generate()
    %OffsetCursor.UpdateCursor()
    Generate()

func Generate():
    pos = Vector2i(0 - (width / 2), 0 - (height / 2))

    for x in width:
        %CanvasBorder.set_cell(Vector2i(pos.x + x, pos.y), 0, Vector2i.ZERO)
    for x in width:
        %CanvasBorder.set_cell(Vector2i(pos.x + x, pos.y + height), 0, Vector2i.ZERO)
    for y in height:
        %CanvasBorder.set_cell(Vector2i(pos.x, pos.y + y), 0, Vector2i.ZERO)
    for y in height:
        %CanvasBorder.set_cell(Vector2i(pos.x + width, pos.y + y), 0, Vector2i.ZERO)
    %CanvasBorder.set_cell(Vector2i(pos.x + width, pos.y + height), 0, Vector2i.ZERO)


func _on_change_canvas_pressed():
    width = %CanvasWidth.value
    height = %CanvasHeigth.value
    %CanvasBorder.clear()
    Generate()
    %OffsetCursor.UpdateCursor()
