extends CharacterBody2D

@export var PlayerID : int
@export var Sprites : Node2D
@export var IsAI : bool
var Anim
var SpriteSheet

func _ready():
	if PlayerID == 0:
		VariableNodes.Player1 = self
	
	var Character = FilePaths.Avatars[FilePaths.Characters_selected.get("default", 0)]
	$Motion.multiplier = clamp(Character["movement multiplier"], 10, 1000)
	$Motion.walk_speed = clamp(Character["walk speed"], 10, 1000)
	$Motion.dash = clamp(Character["dash speed"], 10, 1000)
	
	var heroe_folder = FilePaths.Characters_list[FilePaths.Characters_selected.get("default", 0)][1]
	var heroe_scene_path = FilePaths.root_folder + "/objects/characters/" + heroe_folder + Character["sprites scene"]
	
	var tmp0 = load(heroe_scene_path)
	var tmp = tmp0.instantiate()
	tmp.name = "Sprites"
	add_child(tmp)
	Sprites = tmp
	Anim = Sprites.get_node("Anim")
	SpriteSheet = Sprites.get_node("Sprites/SpriteSheet")
	
	if not IsAI:
		%ATTACKS.Anim = Anim


func EndAnim():
	%Transitions.EndAnimations()

func EndAIAnim():
	%AITransitions.EndAnimations()
