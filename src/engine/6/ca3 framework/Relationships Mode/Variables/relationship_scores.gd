extends Node

var relationships = [
	0, 0, 0
]

var cards_won = [
	0, 0, 0
]

var relationships_names = [
	"lee 1",
	"not lee 2",
	"superior lee 3",
]


func Reset():
	
	for i in relationships:
		i = 0
	
	for i in cards_won:
		i = 0
