extends Node2D

@export var TeamID : int
@export var spawn_number_enemy : int
@export var enemy01 : PackedScene
@export var hadouken_spammer : PackedScene
@export var healer : PackedScene
@export var necromancer : PackedScene

func _ready():
	VariableNodes.AIDirector = self

func Spawn():
	var x = randf_range($TOPLEFT.global_position.x, $BOTTOMRIGHT.global_position.x)
	var y = randf_range($TOPLEFT.global_position.y, $BOTTOMRIGHT.global_position.y)
	var tmp 
	if VariableNodes.Level <= 3 :
		tmp = enemy01.instantiate()
	else:
		if randi_range(0, 10) > 6:
			if randi_range(0, 10) > 5:
				tmp = hadouken_spammer.instantiate()
			else:
				tmp = healer.instantiate()
		else:
			tmp = enemy01.instantiate()
	tmp.global_position = Vector2(x, y)
	$Enemies.add_child(tmp)

func SpawnNecromancer():
	var x = randf_range($TOPLEFT.global_position.x, $BOTTOMRIGHT.global_position.x)
	var y = randf_range($TOPLEFT.global_position.y, $BOTTOMRIGHT.global_position.y)
	var tmp = necromancer.instantiate()
	tmp.global_position = Vector2(x, y)
	$Enemies.add_child(tmp)



func NecroSpawn(x, y):
	
	if (get_tree().get_nodes_in_group("ENEMY").size() / 3) > VariableNodes.Level + 4:
		return
	
	var tmp 
	if VariableNodes.Level <= 3 :
		tmp = enemy01.instantiate()
	else:
		if randi_range(0, 10) > 6:
			if randi_range(0, 10) > 5:
				tmp = hadouken_spammer.instantiate()
			else:
				tmp = healer.instantiate()
		else:
			tmp = enemy01.instantiate()
	tmp.global_position = Vector2(x, y)
	$Enemies.add_child(tmp)
