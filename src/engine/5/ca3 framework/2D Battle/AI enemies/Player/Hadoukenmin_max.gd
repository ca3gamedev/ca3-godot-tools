extends Node

@export var decision : decision_type
enum decision_type {chase, flee}

@export var chase_score = 0
@export var flee_score = 0
@export var coin_score = 0
@export var flee_enemy = 0
@export var team_chase_bonus = 0

enum distance_types { MELEE, LONG_MELEE, MID, LONG, FAR}
@export var favorite_distance : distance_types
@export var playeroffset : Vector2

func Update():
	chase_score = 20
	flee_score = 0
	coin_score = 0
	flee_enemy = 0
	if %FuzzyEvaluator.distance_type > favorite_distance and %ConditionsCheck.distance < %FuzzyEvaluator.max_check:
		flee_score += 10
	if %FuzzyEvaluator.distance_type < favorite_distance and %ConditionsCheck.distance > 20:
		chase_score += 10
	if %DetectorList.closest_coin != null and %DetectorList.closest_coin_distance < 100:
		coin_score += 20
	if %DetectorList.closest_enemy != null and %DetectorList.closest_enemy_distance < 50:
		flee_enemy += 500
		chase_score = 10
	
	if %ConditionsCheck.distance > %FuzzyEvaluator.long_check + 50:
		chase_score += 800
	
	if %FuzzyEvaluator.distance_type > favorite_distance:
		chase_score += 300
	
	chase_score += team_chase_bonus
	
	if chase_score > 1000:
		chase_score = 1000
	
	if %FuzzyEvaluator.distance_type > favorite_distance:
		flee_score = 500
		chase_score = 10
	
	
	#EVALUATIONS
	
	if $"../../".global_position.distance_to(VariableNodes.Player1.global_position) < 30:
		%DecisionOutput.target = VariableNodes.Player1.global_position
		%DecisionOutput.tier = 4
		%DecisionOutput.linearflee = true
		%DecisionOutput.linearchase = false
		return
	
	if coin_score > flee_score and coin_score > chase_score and coin_score > flee_enemy:
		%DecisionOutput.target = %DetectorList.closest_coin.global_position
		%DecisionOutput.linearflee = false
		%DecisionOutput.linearchase = true
		return
	if flee_enemy > chase_score and coin_score < flee_enemy:
		%DecisionOutput.target = %DetectorList.closest_enemy
		%DecisionOutput.linearflee = true
		%DecisionOutput.linearchase = false
		return
	if flee_score > chase_score:
		%DecisionOutput.target = VariableNodes.Player1.global_position
		%DecisionOutput.linearflee = true
		%DecisionOutput.linearchase = false
		return
	
	%DecisionOutput.target = VariableNodes.Player1.global_position + playeroffset
	%DecisionOutput.linearflee = false
	%DecisionOutput.linearchase = true
