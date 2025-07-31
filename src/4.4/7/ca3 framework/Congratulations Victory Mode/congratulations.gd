extends Node2D

var id = 0

func _ready():
	for i in 3:
		Update(i)
	
	var text = ""
	for i in 3:
		text += GetText(i)
	
	%LOG.text = text
	

func Update(id):
	if RelationshipScores.relationships[id] > 95:
		RelationshipScores.cards_won[id] += 1
		RelationshipScores.relationships[id] = 0

func GetText(id):
	var text = ""
	text += "***   "
	text += RelationshipScores.relationships_names[id]
	text += "   ***"
	text += "\n"
	text += "You have won " + str(RelationshipScores.cards_won[id]) + " cards!!!"
	text += "\n"
	text += "Your current score is " + str(RelationshipScores.relationships[id])
	text += "\n"
	return text


func _on_timer_timeout():
	Transitions.Next = SceneDirectory.GetNextLevel("VN")
	Transitions.Start()
