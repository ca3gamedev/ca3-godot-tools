extends Node

# DECISION NODE 2D

@export var linear : bool
@export var linearchase : bool
@export var linearflee : bool

@export var AIMotion : Node

@export var target : Vector2

@export var tier : distance_types
enum distance_types { MELEE, LONG_MELEE, MID, LONG, FAR}


func Update():
	if linear:
		var pos = $"../..".global_position + %ConditionsCheck.aioffset
		if linearchase and tier < %FuzzyEvaluator.distance_type:
			var angle = (target - pos).normalized()
			AIMotion.motion = angle
			return
		if linearflee:
			var angle = (pos - target).normalized()
			AIMotion.motion = angle
			return
	AIMotion.motion = Vector2.ZERO
