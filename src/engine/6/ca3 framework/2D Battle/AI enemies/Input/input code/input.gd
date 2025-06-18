extends Node

@export var idle_time : float
@export var is_idle : bool
@export var idle_count : int
@export var attack_time : float
@export var fireball : bool

func _ready():
	idle_time = randf_range(1, 2.5)
	$IDLE.start(idle_time)
	attack_time = randf_range(1, 2.5)
	$Attack.start(attack_time)

func _process(delta):
	$ConditionsCheck.Update()
	
	if %ConditionsCheck.distance < 100 and idle_count != 2:
		Update()
	if %ConditionsCheck.distance < 80:
		$Attacks.Update()

func _on_update_timeout():
	if is_idle:
		$DecisionOutput.AIMotion.motion = Vector2.ZERO
	else:
		Update()

func Update():
	$DetectorList.Update()
	$FuzzyEvaluator.Update()
	$MinMax.Update()
	$DecisionOutput.Update()
	$LOGAI.LOG()
	if fireball:
		$Fireball.Update()

func _on_idle_timeout():
	idle_count += 1
	if idle_count > 3:
		idle_count = 0
	if idle_count == 2:
		is_idle = true
	else:
		is_idle = false
