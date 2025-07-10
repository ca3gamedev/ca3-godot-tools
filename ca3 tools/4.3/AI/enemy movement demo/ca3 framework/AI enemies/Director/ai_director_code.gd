extends Node

@export var radius_close = 120
@export var radius_medium = 180
@export var radius_far = 270

@export var closest_enemy : CharacterBody2D
@export var distance_tiers = []
@export var tiers = []

func GetClosestEnemy():
	
	var minimal_distance = 99999
	for i in $"../Enemies".get_children():
		if i.GetDistance() < minimal_distance:
			minimal_distance = i.GetDistance()
			closest_enemy = i
	
	if closest_enemy != null:
		closest_enemy.AddChaseScore(5000, true)
		closest_enemy.SetPlayerOffset(Vector2(0, 0))

func DistanceSort():
	
	distance_tiers = []
	for i in len($"../Enemies".get_children()):
		$"../Enemies".get_child(i).ResetClosest()
		$"../Enemies".get_child(i).SetPlayerOffset(Vector2(0, 0))
		distance_tiers.append([$"../Enemies".get_child(i).GetDistance(), $"../Enemies".get_child(i)])
	
	distance_tiers.sort_custom(SortDistance)
	
	var tier_limit = int(len(distance_tiers) * 0.25)
	
	tiers = [[], [], [], []]
	
	if len(distance_tiers) <= 4:
		for i in len(distance_tiers):
			tiers[int(i % 4)].append(distance_tiers[i][1])
	else:
		for i in len(distance_tiers):
			tiers[int(i / 4)-1].append(distance_tiers[i][1])
	
	for x in len(tiers):
		for i in tiers[x]:
			var tier = x
			if tier == 0:
				tier = 1
			if tier > 4:
				tier = 4
			i.SetDistanceTier(tier)

func GetCircle():
	posicionar_en_circulo(tiers[1], Vector2.ZERO, radius_close)
	posicionar_en_circulo(tiers[2], Vector2.ZERO, radius_medium)
	posicionar_en_circulo(tiers[3], Vector2.ZERO, radius_far)


func posicionar_en_circulo(array: Array, centro: Vector2, radio: float):
	var total = array.size()
	if total == 0:
		return

	for i in range(total):
		var angle_deg = (360 / total) * i
		var angle_rad = deg_to_rad(angle_deg)  # Convertir a radianes para sin() y cos()

		var x = centro.x + cos(angle_rad) * radio
		var y = centro.y + sin(angle_rad) * radio
		array[i].SetPlayerOffset(Vector2(x, y))

func _on_closest_update_timeout():
	DistanceSort()
	GetCircle()
	GetClosestEnemy()

func SortDistance(a, b):
	if a[0] < b[0]:
		return true
	return false
