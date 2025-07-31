extends Node

var grass_tiles = []
var room_center = []
var path_tiles = []

func _ready():
	MakeDungeon()
	var local = %Map.map_to_local(room_center[0])
	var global = %Map.to_global(local)
	%Player.global_position = global
	%Camera2D.global_position = global

func _process(delta):
	
	%Camera2D.global_position = %Camera2D.global_position.slerp(%Player.global_position, delta * 2)
	%TimerLOG.value = %Timer.time_left


func MakeDungeon():
	MakeRooms()
	MakePaths()


func MakeRooms():
	for i in 10:
		MakeRoom()
	
	for x in 80:
		for y in 80:
			if %Map.get_cell_source_id(Vector2i(x-10, y-10)) == -1:
				%Map.set_cell(Vector2i(x-10, y-10), 3, Vector2i.ZERO)

func MakeRoom():
	var x = randi_range(0, 50)
	var y = randi_range(0, 50)
	var w = randi_range(5, 20)
	var h = randi_range(5, 20)
	
	room_center.append(Vector2i(x+(w/2), y+(h/2)))
	
	for ix in w:
		for iy in h:
			grass_tiles.append(Vector2i(x+ix, y+iy))
			%Map.set_cell(Vector2i(x+ix, y+iy), 0, Vector2i.ZERO)
	
	%Map.set_cells_terrain_connect(grass_tiles, 0, 1, true)

func MakePaths():
	for i in len(room_center)-1:
		MakePath(room_center[i], room_center[i+1])
	
	%Map.set_cells_terrain_connect(path_tiles, 0, 0, true)
	
func MakePath(start, goal):
	
	if goal.distance_to(start) < 2:
		return
	
	path_tiles.append(start)
	path_tiles.append(start + Vector2i.LEFT)
	path_tiles.append(start + Vector2i.RIGHT)
	path_tiles.append(start + Vector2i.UP)
	path_tiles.append(start + Vector2i.DOWN)
	
	var angle = goal - start
	print(angle)
	
	if randi_range(0, 10) > 5:
		MakePath(start + Vector2i(sign(angle.x), 0), goal)
	else:
		MakePath(start + Vector2i(0, sign(angle.y)), goal)


func _on_timer_timeout():
	
	Transitions.Next = SceneDirectory.GetScreen("World Map")
	VariableNodes.battle_won = true
	Transitions.Start()
