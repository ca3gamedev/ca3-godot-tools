extends Node


func NEWFILL():
    %cachescript.SaveCache()
    %"LAYERS".current_tilemap.clear()
    MapInstancing()
    %"LAYERS".current_tilemap.update_internals()


func MapInstancing():
    for x in %SIZEX.value:
        for y in %SIZEY.value:
            var pos = %Math.ClampV2(x + %OFFSETX.value, y + %OFFSETY.value)
            %"LAYERS".current_tilemap.set_cell(pos, %TileID1.selected, Vector2i.ZERO)


func ADDFILL():
    %cachescript.SaveCache()
    MapInstancing()
    %"LAYERS".current_tilemap.update_internals()

func Clear():
    %cachescript.SaveCache()
    %"LAYERS".current_tilemap.clear()

func Save():
    %Cache.tile_map_data = %"LAYERS".current_tilemap.tile_map_data
    %Cache.update_internals()

func Algo1():
    %cachescript.SaveCache()
    Algo1Gen()
    %"LAYERS".current_tilemap.update_internals()


func Algo1Gen():
    for i in %SANDITERATIONS.value:
        for x in %SIZEX.value:
            for y in %SIZEY.value:
                var chance = randi_range(1, %SANDCHANCE.value)
                var pos = %Math.ClampV2(x + %OFFSETX.value, y + %OFFSETY.value)
                if int(chance) == 2:
                    %"LAYERS".current_tilemap.set_cell(pos, %TileID1.selected, Vector2i.ZERO)
                if int(chance) == int(( %SANDCHANCE.value / 3) * 2):
                    %"LAYERS".current_tilemap.set_cell(pos, %TileID2.selected, Vector2i.ZERO)
    %"LAYERS".current_tilemap.update_internals()

func RandomWalk():
    %cachescript.SaveCache()
    RandomWalkGen(Vector2i( %OFFSETX.value, %OFFSETY.value), 0, %RWIterations.value)
    %"LAYERS".current_tilemap.update_internals()

func RandomWalkGen(pos, i, id):
    if i > id:
        return

    if %RWSkip.button_pressed:
        if int(i) %int( %SkipStep.value) != 0:
            %"LAYERS".current_tilemap.set_cell(pos, %TileID1.selected, Vector2i.ZERO)
    elif %RWRandom.button_pressed:
        if randi_range(0, 4) > 2:
            %"LAYERS".current_tilemap.set_cell(pos, %TileID1.selected, Vector2i.ZERO)
        if randi_range(0, 4) == 3:
            %"LAYERS".current_tilemap.set_cell(pos, %TileID2.selected, Vector2i.ZERO)
    else:
        %"LAYERS".current_tilemap.set_cell(pos, %TileID1.selected, Vector2i.ZERO)

    var new_pos = pos + GetRandomStep()
    new_pos = %Math.ClampV2(new_pos.x, new_pos.y)

    RandomWalkGen(new_pos, i + 1, id)

func GetRandomStep():
    var dir = randi_range(0, 5)
    match (dir):
        0: return Vector2i.UP
        1: return Vector2i.LEFT
        2: return Vector2i.RIGHT
        3: return Vector2i.UP
        4: return Vector2i.DOWN

    return Vector2i.DOWN


func DirectWalk():
    var pos = %Math.ClampV2( %OFFSETX.value, %OFFSETY.value)
    var end = %Math.ClampV2( %ENDX.value, %ENDY.value)
    DirectStep(pos, end, 0)

func DirectStep(start, end, id):
    if start == end:
        return

    %"LAYERS".current_tilemap.set_cell(start, %TileID1.selected, Vector2i.ZERO)

    var new_pos = end - start
    var dir = Vector2i(sign(new_pos.x), sign(new_pos.y))

    DirectStep(start + dir, end, id + 1)


func Algo2():
    %cachescript.SaveCache()
    Algo1Gen()
    %"LAYERS".current_tilemap.update_internals()


func Algo2Gen():
    for i in %SANDITERATIONS.value:
        for x in %SIZEX.value:
            for y in %SIZEY.value:
                var chance = randi_range(1, %SANDCHANCE.value)
                var pos = %Math.ClampV2(x + %OFFSETX.value, y + %OFFSETY.value)
                if int(chance) == 2:
                    %"LAYERS".current_tilemap.set_cell(pos, %TileID1.selected, Vector2i.ZERO)
                if int(chance) == int(( %SANDCHANCE.value / 3) * 2):
                    %"LAYERS".current_tilemap.set_cell(pos, %TileID2.selected, Vector2i.ZERO)
    %"LAYERS".current_tilemap.update_internals()


func GenerateBush():

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
                %"LAYERS".current_tilemap.set_cell(Vector2i(x + %OFFSETX.value, y + %OFFSETY.value), %TileID1.selected, Vector2i.ZERO)

func RandomPos():
    var size_x = randi_range(0 - ( %CanvasWidth.value - 1) / 2, ( %CanvasWidth.value - 1) / 2)
    var size_y = randi_range(0 - ( %CanvasHeigth.value - 1) / 2, ( %CanvasHeigth.value - 1) / 2)
    var pos = %Math.ClampV2(size_x, size_y)
    %"LAYERS".current_tilemap.set_cell(pos, %TileID1.selected, Vector2i.ZERO)
