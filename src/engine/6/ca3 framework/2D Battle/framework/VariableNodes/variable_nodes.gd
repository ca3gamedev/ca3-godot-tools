extends Node

@export var StartHP : int
@export var StartMana : int
@export var StartPlayerDamage : int
@export var StartEnemyDamage : int
@export var coins : int


@export var MyCamera2D : Camera2D
@export var PlayerBulletManager : Node2D
@export var EnemyBulletManager : Node2D

@export var Player1 : CharacterBody2D
@export var Player1_3D : CharacterBody3D

@export var HP : int
@export var Mana : int 
@export var player_damage : int
@export var enemy_damage : int
@export var Level : int

@export var GUI : Node2D

@export var Combo : int
@export var MaxCombo : int
@export var AIDirector : Node2D
@export var PlayerPosMap : int

var country = ""

var map
var maptiles
var levels_finished
@export var battle_won : bool

@export var MapCreated : bool

@export var Countries_finished : Array[bool]
@export var Countries_selected : int

func _ready():
	randomize()


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
	coins = 0
	PlayerPosMap = 0 
	MapCreated = false
	battle_won = false
	Countries_selected = 0
	
	for i in Countries_finished:
		i = false

func GameOver():
	Music.STOPSONG()
	Transitions.Next = SceneDirectory.GetScreen("Game Over")
	VariableNodes.battle_won = true
	Transitions.Start()

func AddComboKill():
	Combo += 1
	$ComboReset.start(1)


func _on_combo_reset_timeout():
	if Combo > MaxCombo:
		MaxCombo = Combo
	Combo = 0
