extends CharacterBody3D

@export var IsP1 : bool
@export var IsAI : bool

@export var Oponent : CharacterBody3D
@export var damage : int

func HITSTOP():
	GUI.AddHit()
	$HitStop.start(0.05)
	PAUSE.call_deferred()
	
func PAUSE():
	self.process_mode = Node.PROCESS_MODE_DISABLED
	
func UNPAUSE():
	self.process_mode = Node.PROCESS_MODE_INHERIT


func _on_hit_stop_timeout() -> void:
	UNPAUSE()
