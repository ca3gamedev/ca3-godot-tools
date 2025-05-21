extends CharacterBody2D

@export var PlayerID : int

func _ready():
	if PlayerID == 0:
		VariableNodes.Player1 = self
