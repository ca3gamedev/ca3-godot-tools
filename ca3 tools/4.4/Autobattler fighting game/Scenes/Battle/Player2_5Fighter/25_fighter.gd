extends CharacterBody3D

@export var IsP1 : bool
@export var IsAI : bool

@export var Player : CharacterBody3D
@export var Oponent : Array[Node]
@export var damage : int
@export var Closest : Node

func _ready() -> void:
	Oponent = get_tree().get_nodes_in_group("ENEMY")
	var player = get_tree().get_nodes_in_group("PLAYER")
	Player = player[0]
	
	Player.collision_layer = 2
	Player.collision_mask = 2 | 4 | 8 | 16
	var material = Player.get_node("Shadow").material_override
	material.albedo_color = Color.BLUE
	for i in Oponent:
		i.collision_layer = 4
		i.collision_mask = 2 | 8 | 16
		material = i.get_node("Shadow").material_override
		material.albedo_color = Color.RED
		
	


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
