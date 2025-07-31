extends CharacterBody2D

@export var PlayerID : int
@export var Sprites : Node2D
@export var IsAI : bool
@export var Anim : AnimationTree
@export var SpriteSheet : AnimatedSprite2D

func _ready():
	if PlayerID == 0:
		VariableNodes.Player1 = self
		
	$"Motion AnimTree".Anim = Anim


func EndAnim():
	%Transitions.EndAnimations()

func EndAIAnim():
	%AITransitions.EndAnimations()
