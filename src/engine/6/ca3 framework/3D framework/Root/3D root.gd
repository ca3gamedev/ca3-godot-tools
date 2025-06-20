extends Node3D

var is_store = false

func _ready():
	%Country.text = VariableNodes.country

func UNPAUSE():
	if is_store:
		return
	$Player3D.process_mode = Node.PROCESS_MODE_INHERIT
	$npcs.process_mode = Node.PROCESS_MODE_INHERIT

func PAUSE():
	$Player3D.process_mode = Node.PROCESS_MODE_DISABLED
	$npcs.process_mode = Node.PROCESS_MODE_DISABLED

func DIALOGPAUSE():
	$DialogsNPC.StartDialog()
	PAUSE()

func RELATIONSHIPPAUSE():
	$"NPC Relationship baloon".Start()
	PAUSE()
