extends Node

@export var bushlayer: TileMapLayer


func Generate():

    var Map = []
    for x in %SIZEX.value:
        Map.append([])
        for y in %SIZEY.value:
            Map[x].append([])
            Map[x][y] = 0

    for i in %IterationsBush.value:
        for x in %SIZEX.value:
            for y in %SIZEY.value:
                var chance = randi_range(1, %ChanceBush.value)
                if chance == 2:
                    Map[x][y] += 0.2

    for x in %SIZEX.value:
        for y in %SIZEY.value:
            if Map[x][y] > %ThressholdBush.value:
                bushlayer.set_cell(Vector2i(x + %OFFSETX.value, y + %OFFSETY.value), 0, Vector2i.ZERO)

func _on_generate_pressed():
    bushlayer.clear()
    Generate()
