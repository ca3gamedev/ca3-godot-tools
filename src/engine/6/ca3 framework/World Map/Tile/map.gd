extends Node2D

@export var tile : PackedScene
@export var space : int
@export var levels_left : int

func _ready():
	
	if not VariableNodes.MapCreated:
		VariableNodes.MapCreated = true
		CREATE_MAP()
	
	if VariableNodes.battle_won:
		VariableNodes.levels_finished[VariableNodes.PlayerPosMap] = true
	
	levels_left = get_child_count()
	
	for x in get_child_count():
		get_child(x).SetID(VariableNodes.map[x])
		if VariableNodes.levels_finished[x]:
			levels_left -= 1
			get_child(x).DISABLE()
	
	var PlayerPos = VariableNodes.PlayerPosMap
	%Player.global_position = get_child(PlayerPos).global_position
	%CameraParent.global_position = %Player.global_position
	
	%Levels_Left.text = str(levels_left)
	
	if levels_left < 1:
		VariableNodes.battle_won = false
		Transitions.Next = SceneDirectory.GetScreen("Congratulations")
		Transitions.Start()

func CREATE_MAP():
	
	VariableNodes.battle_won = false
	VariableNodes.map = []
	VariableNodes.levels_finished = []
	VariableNodes.maptiles = []
	for x in get_child_count():
		VariableNodes.map.append([])
		VariableNodes.maptiles.append([])
		VariableNodes.levels_finished.append([])
		VariableNodes.levels_finished[x] = false
		VariableNodes.map[x] = randi() % 9
		get_child(x).tile_id = VariableNodes.map[x]

func _process(delta):
	
	%Player.global_position = lerp(%Player.global_position, get_child(VariableNodes.PlayerPosMap).global_position, delta * 4)
	%CameraParent.global_position = %CameraParent.global_position.slerp(%Player.global_position, delta * 3)
	
	if get_child(VariableNodes.PlayerPosMap).left != -9 and Input.is_action_just_released("LEFT"):
		VariableNodes.PlayerPosMap = get_child(VariableNodes.PlayerPosMap).left
	if get_child(VariableNodes.PlayerPosMap).right != -9 and Input.is_action_just_released("RIGHT"):
		VariableNodes.PlayerPosMap = get_child(VariableNodes.PlayerPosMap).right
	if get_child(VariableNodes.PlayerPosMap).up != -9 and Input.is_action_just_released("UP"):
		VariableNodes.PlayerPosMap = get_child(VariableNodes.PlayerPosMap).up
	if get_child(VariableNodes.PlayerPosMap).down != -9 and Input.is_action_just_released("DOWN"):
		VariableNodes.PlayerPosMap = get_child(VariableNodes.PlayerPosMap).down
	
		 
	if Input.is_action_just_released("A") and not VariableNodes.levels_finished[VariableNodes.PlayerPosMap]:
		var tile_id = VariableNodes.map[VariableNodes.PlayerPosMap]
		match(tile_id):
			0: Transitions.Next = SceneDirectory.GetNextLevel("Victory Points")
			1: Transitions.Next = SceneDirectory.GetNextLevel("Victory Points")
			2: Transitions.Next = SceneDirectory.GetNextLevel("Intro")
			3: Transitions.Next = SceneDirectory.GetNextLevel("Battle")
			4: 
				match(randi()%3):
					0 : Transitions.Next = SceneDirectory.GetNextLevel("Level 01")
					1 : Transitions.Next = SceneDirectory.GetNextLevel("Level 02")
					2 : Transitions.Next = SceneDirectory.GetNextLevel("Level 03")
			5 : Transitions.Next = SceneDirectory.GetNextLevel("Relationships")
			6 : Transitions.Next = SceneDirectory.GetNextLevel("Roguelike")
			7 : Transitions.Next = SceneDirectory.GetNextLevel("2D turn Fighter")
			8 : Transitions.Next = SceneDirectory.GetNextLevel("Tarot")
		
		VariableNodes.battle_won = false
		
		Transitions.Start()
