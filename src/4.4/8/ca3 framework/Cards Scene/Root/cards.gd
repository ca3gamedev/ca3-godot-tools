extends Node2D

var target = 0
var final : float

func _ready():
	$Ani.animation = "empty"

func _process(delta):
	
	$ProgressBar.value = lerp($ProgressBar.value, final, delta * 2)

func _on_lee_1_timeout():
	$Ani.animation = "default"
	$LOG.text = "LEE 1"
	$ProgressBar.value = RelationshipScores.relationships[0]
	
	PICKCARD()
	RelationshipScores.relationships[0] += target
	final = RelationshipScores.relationships[0]
	$Lee2.start(4)
	

func PICKCARD():
	var type = randi() % 4
	$Ani.frame = type
	match(type):
		0 : target = (randi() % 10) * -1
		1 : target = randi() % 10
		2 : target = randi() % 20
		3 : target = (randi() % 20) * -1
	$card.text = str(target)


func _on_lee_2_timeout():
	$LOG.text = "LEE 2"
	$ProgressBar.value = RelationshipScores.relationships[1]
	
	PICKCARD()
	RelationshipScores.relationships[1] += target
	final = RelationshipScores.relationships[1]
	$Lee3.start(4)


func _on_lee_3_timeout():
	$LOG.text = "LEE 3"
	$ProgressBar.value = RelationshipScores.relationships[2]
	
	PICKCARD()
	RelationshipScores.relationships[2] += target
	final = RelationshipScores.relationships[2]
	$End.start(4)


func _on_end_timeout():
	Transitions.Next = SceneDirectory.GetScreen("World Map")
	VariableNodes.battle_won = true
	Transitions.Start()
