extends Node2D

var id_x : int
var id_y : int
var idle : bool
var chara : int

var relationship_points = 0
var npc_name : String
var unlocked : int

func _ready():
	id_x = 0
	id_y = 0
	SelectType()

func SelectType():
	match(chara):
		0 : 
			npc_name = RelationshipScores.relationships_names[0]
			relationship_points = RelationshipScores.relationships[0]
			unlocked = RelationshipScores.cards_won[0]
		1 : 
			npc_name = RelationshipScores.relationships_names[1]
			relationship_points = RelationshipScores.relationships[1]
			unlocked = RelationshipScores.cards_won[1]
		2 : 
			npc_name = RelationshipScores.relationships_names[2]
			relationship_points = RelationshipScores.relationships[2]
			unlocked = RelationshipScores.cards_won[2]
	%CharName.text = npc_name
	%ProgressBar.value = relationship_points
	%Unlocked.text = "You have unlocked " + str(unlocked) + " cards"

func SetNames(npc_name, relationship_points):
	%CharName.text = npc_name
	%ProgressBar.value = relationship_points

func _process(delta):
	var pos = get_node(str(id_y)).get_node(str(id_x)).global_position
	$Camera2D.global_position = $Camera2D.global_position.slerp(pos, delta * 4)
	
	if Input.is_action_just_released("LEFT"):
		if id_x > 0:
			id_x -= 1
	
	if Input.is_action_just_released("RIGHT"):
		if id_x < get_node(str(id_y)).get_child_count()-1:
			id_x += 1
	
	if Input.is_action_just_released("UP"):
		if chara > 0:
			chara -= 1
			id_y = chara
			SelectType()
	
	if Input.is_action_just_released("DOWN"):
		if chara < 2:
			chara += 1
			id_y = chara
			SelectType()
	
	if Input.is_action_just_released("A"):
		id_x = 0
		id_y = 0
		$Change.start(1.5)
	if Input.is_action_just_released("B"):
		$Change.stop()
	
	if Input.is_action_just_released("X"):
		Transitions.Next = SceneDirectory.GetScreen("Overworld")
		Transitions.Start()


func _on_change_timeout():
	
	id_x += 1
	if id_x >= get_node(str(id_y)).get_child_count()-1:
		id_x = 0
		id_y += 1
	if id_y > 2:
		id_y = 0
	
