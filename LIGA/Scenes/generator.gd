extends Node

@export var tile_scene: PackedScene
@export var dungeon_size: Vector2i
@export var tile_offset: int
@export var number_rooms: int
@export var room_size: Vector2i

var Map = []
var MapTiles = []
var RoomsCenter = []

func BEGIN():
    MapInstancing()
    MapGeneration()
    TilesInstancing()
    GenerateRooms()
    ConnectRooms()
    DebugRoomSeeds()
    TilesColors()

func MapInstancing():
    for x in dungeon_size.x:
        Map.append([])
        MapTiles.append([])
        for y in dungeon_size.y:
            Map[x].append([])
            MapTiles[x].append([])
            Map[x][y] = Color(0.0, 0.0, 0.0)

func MapGeneration():
    for i in 4:
        for x in dungeon_size.x:
            for y in dungeon_size.y:
                if randi_range(0, 3) == 2:
                    Map[x][y].r += 0.25

func TilesInstancing():
    for x in dungeon_size.x:
        for y in dungeon_size.y:
            InstanceTile(x, y)


func InstanceTile(x, y):
    var tmp = tile_scene.instantiate()
    tmp.position = Vector2(x * tile_offset, y * tile_offset)
    MapTiles[x][y] = tmp
    add_child(MapTiles[x][y])

func TilesColors():
    for x in dungeon_size.x:
        for y in dungeon_size.y:
            SetColor(x, y)

func SetColor(x, y):
    MapTiles[x][y].SetColor(Map[x][y])

func GenerateRooms():
    for i in number_rooms:
        var x = randi_range(5, dungeon_size.x - 5)
        var y = randi_range(5, dungeon_size.y - 5)
        var w = randi_range(3, room_size.x)
        var h = randi_range(3, room_size.y)

        RoomsCenter.append([])

        var center_x = x + (w / 2)
        var center_y = y + (h / 2)
        RoomsCenter[i] = Vector2i(center_x, center_y)


        SetRoomTile(x, y, w, h, 0.2)

func SetRoomTile(xpos, ypos, w, h, weight):

    for x in w:
        for y in h:
            var x2 = clampi((x + xpos) - (w / 2), 1, dungeon_size.x - 2)
            var y2 = clampi((y + ypos) - (h / 2), 1, dungeon_size.y - 2)
            Map[x2][y2].g += weight

func ConnectRooms():
    for i in RoomsCenter.size() - 1:
        PathCalculation(RoomsCenter[i], RoomsCenter[i + 1])

func PathCalculation(start, goal):
    PathLoop(start, goal, 0)

func PathLoop(start, goal, i):
    if start == goal:
        return
    if i > 2000:
        return
    var dir = start
    dir = SetPath(start, goal)
    var c_dir = Vector2i.ZERO
    c_dir.x = clampi(dir.x, 1, dungeon_size.x - 2)
    c_dir.y = clampi(dir.y, 1, dungeon_size.y - 2)
    Map[c_dir.x][c_dir.y].b += 0.25
    dir += GetRandomWalk()
    c_dir.x = clampi(dir.x, 1, dungeon_size.x - 2)
    c_dir.y = clampi(dir.y, 1, dungeon_size.y - 2)
    Map[c_dir.x][c_dir.y].b += 0.25
    if randf_range(0, 10) > 5:
        dir += GetRandomWalk()
        c_dir.x = clampi(dir.x, 1, dungeon_size.x - 2)
        c_dir.y = clampi(dir.y, 1, dungeon_size.y - 2)
        Map[c_dir.x][c_dir.y].b += 0.25
    else:
        dir = SetPath(dir, goal)

    PathLoop(dir, goal, i + 1)

func SetPath(start, goal):
    var clamped_pos = Vector2i.ZERO
    clamped_pos.x = clampi(start.x, 1, dungeon_size.x - 2)
    clamped_pos.y = clampi(start.y, 1, dungeon_size.y - 2)

    Map[clamped_pos.x][clamped_pos.y].b = 1

    var new_movement = clamped_pos + GetNextManhattan(clamped_pos, goal)
    return new_movement

func GetNextManhattan(start, goal):
    var tmp = goal - start
    var x = sign(tmp.x)
    var y = sign(tmp.y)
    var dir = Vector2i.ZERO
    if randi_range(0, 10) > 5:
        dir.x = x
    else:
        dir.y = y
    return dir

func GetRandomWalk():
    var dir = randi_range(0, 5)
    var new_dir = Vector2i.ZERO
    match (dir):
        1: new_dir.x = -1
        2: new_dir.x = 1
        3: new_dir.y = -1
        4: new_dir.y = 1
    return new_dir

func DebugRoomSeeds():

    for i in RoomsCenter.size():
        var pos = RoomsCenter[i]
        var x = clampi(pos.x, 1, dungeon_size.x - 2)
        var y = clampi(pos.y, 1, dungeon_size.y - 2)
        Map[x][y] = Color.WHITE
