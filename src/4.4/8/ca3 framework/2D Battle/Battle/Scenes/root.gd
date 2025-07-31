extends Node2D

var pause = false


func _ready():
	Frame.LOG(Log.Fight, 4.0, true)
	Music.STOPSONG()
	Music.PLAYSONG()
	Transitions.Next = "null"
	VariableNodes.Level = 3
	VariableNodes.HP += 20
	VariableNodes.HP = clampi(VariableNodes.HP, 0, 100)
	$AIDirector.spawn_number_enemy = VariableNodes.Level
	for i in (VariableNodes.Level / 5) + 3:
		$CoinSpawner.Spawn()
	for i in VariableNodes.Level:
		$AIDirector.Spawn()
	#if VariableNodes.Level > 5:
	#	$AIDirector.SpawnNecromancer()
	PauseLog.HIDE()


func _process(delta):
	
	if Input.is_action_just_released("PAUSE"):
		pause = !pause
		
		if pause:
			PauseLog.SHOW()
			PAUSE()
		else:
			PauseLog.HIDE()
			UNPAUSE()


func PAUSE():
	$AIDirector.process_mode = Node.PROCESS_MODE_DISABLED
	$EnemyBullets.process_mode = Node.PROCESS_MODE_DISABLED
	$CoinSpawner.process_mode = Node.PROCESS_MODE_DISABLED
	$Players.process_mode = Node.PROCESS_MODE_DISABLED
	$PlayerBulletManager.process_mode = Node.PROCESS_MODE_DISABLED
	$GUI.process_mode = Node.PROCESS_MODE_DISABLED

func UNPAUSE():
	$AIDirector.process_mode = Node.PROCESS_MODE_INHERIT
	$EnemyBullets.process_mode = Node.PROCESS_MODE_INHERIT
	$CoinSpawner.process_mode = Node.PROCESS_MODE_INHERIT
	$Players.process_mode = Node.PROCESS_MODE_INHERIT
	$PlayerBulletManager.process_mode = Node.PROCESS_MODE_INHERIT
	$GUI.process_mode = Node.PROCESS_MODE_INHERIT
