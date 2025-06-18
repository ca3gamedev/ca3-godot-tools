extends Node

func _process(delta):
	$CanvasLayer/LEE1.value = RelationshipScores.relationships[0]
	$CanvasLayer/LEE2.value = RelationshipScores.relationships[1]
	$CanvasLayer/LEE3.value = RelationshipScores.relationships[2]
