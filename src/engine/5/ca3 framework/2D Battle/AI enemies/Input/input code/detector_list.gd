extends Node

@export var coins = []
@export var closest_coin : Node2D
@export var closest_coin_distance : float

@export var enemies = []
@export var closest_enemy : Vector2i
@export var closest_enemy_distance : float


func Update():
	COINSCHECK.call_deferred()
	ENEMYCHECK.call_deferred()

func COINSCHECK():
	var smallest_coin_distance = 999999
	closest_coin_distance = smallest_coin_distance


func ENEMYCHECK():
	var enemy_removal = []
	for i in len(enemies):
		if enemies[i] != null:
			if not is_instance_valid(enemies[i]):
				enemy_removal.append(i)
	for i in enemy_removal:
		if i != null:
			enemies.remove_at(i)
	var smallest_enemy_distance = 999999
	for i in len(enemies):
		if enemies[i] != null:
			var dist = $"../../".global_position.distance_to(enemies[i].global_position)
			if dist < smallest_enemy_distance:
				smallest_enemy_distance = dist
				closest_enemy = enemies[i].global_position
	closest_enemy_distance = smallest_enemy_distance




func _on_detector_area_entered(area):
	
	if area.is_in_group("COIN"):
		area.get_node("../ColorRect").color = Color.ORANGE
		coins.append(area)
	if area.is_in_group("ENEMY"):
		if area.get_node("../").name != get_node("../../").name:
			enemies.append(area.get_node("../"))
