extends Node2D

@export var delay : bool
@onready var target = [0, 0, 0]

func _ready():
	$LEE1.value = RelationshipScores.relationships[0]
	$LEE2.value = RelationshipScores.relationships[1]
	$LEE3.value = RelationshipScores.relationships[2]


func _process(delta):
	
	if delay:
		
		$LEE1.value = lerp($LEE1.value, float(RelationshipScores.relationships[0]), delta)
		$LEE2.value = lerp($LEE2.value, float(RelationshipScores.relationships[1]), delta)
		$LEE3.value = lerp($LEE3.value, float(RelationshipScores.relationships[2]), delta)


func _on_start_timeout():
	$End.start(3)
	delay = true
	
	for i in 3:
		RelationshipScores.relationships[i] += randi_range(1, VariableNodes.coins * 5)


func _on_end_timeout():
	Transitions.Next = SceneDirectory.GetScreen("World Map")
	VariableNodes.battle_won = true
	Transitions.Start()
