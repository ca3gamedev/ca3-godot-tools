extends Node2D

func _ready():
	for i in 5:
		$CoinSpawner.Spawn()
