extends Node

@export var aioffset : Vector2
@export var distance : float

func _ready():
	var melee = %FuzzyEvaluator.melee_check
	var x = randf_range(-melee, melee)
	var y = randf_range(-melee, melee)
	aioffset = Vector2(x, y)

func Update():
	distance = VariableNodes.Player1.global_position.distance_to($"../../".global_position)
