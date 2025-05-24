extends CharacterBody2D

@export var PlayerID : int
@export var Sprites : Node2D
@export var IsAI : bool
var Anim
var SpriteSheet

func _ready():
	if PlayerID == 0:
		VariableNodes.Player1 = self
	
	Sprites = $Sprites
	Anim = Sprites.get_node("Anim")
	SpriteSheet = Sprites.get_node("Sprites/SpriteSheet")
	
	if not IsAI:
		%ATTACKS.Anim = Anim


func EndAnim():
	%Transitions.EndAnimations()

func EndAIAnim():
	%AITransitions.EndAnimations()
