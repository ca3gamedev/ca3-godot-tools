extends Node2D

var id : int
var idle : bool
var chara : int

var relationship_points = 0
var npc_name : String

func _ready():
	idle = true
	VariableNodes.dialog_relationship_npc = self
	$CanvasLayer.hide()
	SelectType()

func SelectType():
	%Anim.frame = 0
	match(chara):
		0 : 
			npc_name = RelationshipScores.relationships_names[0]
			relationship_points = RelationshipScores.relationships[0]
		1 : 
			npc_name = RelationshipScores.relationships_names[1]
			relationship_points = RelationshipScores.relationships[1]
		2 : 
			npc_name = RelationshipScores.relationships_names[2]
			relationship_points = RelationshipScores.relationships[2]
	%CharName.text = npc_name
	$CanvasLayer/ProgressBar.value = relationship_points


func Start():
	%Anim.frame = 0
	idle = false
	$CanvasLayer.show()

func SetNames(npc_name, relationship_points):
	%CharName.text = npc_name
	$CanvasLayer/ProgressBar.value = relationship_points

func _process(delta):
		
	if Input.is_action_just_released("B"):
		if idle:
			SetNames(npc_name, relationship_points)
			$"../".RELATIONSHIPPAUSE()
		else:
			idle = true
			$CanvasLayer.hide()
			$"..".UNPAUSE()
	
	if Input.is_action_just_released("LEFT"):
		%Anim.frame -= 1
	
	if Input.is_action_just_released("RIGHT"):
		%Anim.frame += 1
	
	if Input.is_action_just_released("UP"):
		if chara > 0:
			chara -= 1
			SelectType()
	
	if Input.is_action_just_released("DOWN"):
		if chara < 2:
			chara += 1
			SelectType()
