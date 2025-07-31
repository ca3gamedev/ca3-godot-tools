extends Node2D

@export var left : int = -9
@export var right : int = -9
@export var up : int = -9
@export var down : int = -9

@export var tile_id : int

func DISABLE():
	$Tile.DISABLE()

func SetID(i):
	$Tile.SetID(i)
