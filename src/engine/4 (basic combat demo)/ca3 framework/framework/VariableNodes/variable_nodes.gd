extends Node

@export var StartHP : int
@export var StartMana : int
@export var StartPlayerDamage : int
@export var StartEnemyDamage : int


@export var MyCamera2D : Camera2D
@export var PlayerBulletManager : Node2D
@export var EnemyBulletManager : Node2D

@export var Player1 : CharacterBody2D

@export var HP : int
@export var Mana : int 
@export var player_damage : int
@export var enemy_damage : int
@export var Level : int

@export var GUI : Node2D

@export var Combo : int
@export var MaxCombo : int
@export var AIDirector : Node2D

func DAMAGE():
	HP -= enemy_damage
	GUI.CHANGEHP()

func AddMana():
	Mana += 5
	Mana = clampi(Mana, 0, 100)
	GUI.CHANGEMANA()

func ConsumeStock():
	Mana = 0
	GUI.CHANGEMANA()

func RESETDATA():
	HP = StartHP
	Mana = StartMana
	player_damage = StartPlayerDamage
	enemy_damage = StartEnemyDamage
	Level = 1
	Combo = 0
	MaxCombo = 0

func ResetBattle():
	get_tree().change_scene_to_file("res://ca3 framework/Battle/Scenes/BattleTest.tscn")

func GameOver():
	get_tree().change_scene_to_file("res://data/default/Scenes/GameOver/game_over.tscn")

func AddComboKill():
	Combo += 1
	$ComboReset.start(1)


func _on_combo_reset_timeout():
	if Combo > MaxCombo:
		MaxCombo = Combo
	Combo = 0
