extends Node

@export var distance_type : distance_types
@export var melee_check : float
@export var long_melee_check : float
@export var mid_check : float
@export var long_check : float
@export var max_check : float


enum distance_types { MELEE, LONG_MELEE, MID, LONG, FAR}

func Update():
	
	if %ConditionsCheck.distance < melee_check:
		distance_type = distance_types.MELEE
	if %ConditionsCheck.distance > melee_check and %ConditionsCheck.distance < long_melee_check:
		distance_type = distance_types.LONG_MELEE
	if %ConditionsCheck.distance > long_melee_check and %ConditionsCheck.distance < mid_check:
		distance_type = distance_types.MID
	if %ConditionsCheck.distance > mid_check and %ConditionsCheck.distance < long_check:
		distance_type = distance_types.LONG
	if %ConditionsCheck.distance > long_check:
		distance_type = distance_types.FAR
	
