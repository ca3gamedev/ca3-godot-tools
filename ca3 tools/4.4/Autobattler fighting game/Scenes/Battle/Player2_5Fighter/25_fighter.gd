extends CharacterBody3D

@export var IsP1 : bool
@export var IsAI : bool

@export var ID : int

@export var Player : CharacterBody3D
@export var Player_id : int
@export var Oponent : Array[Node]
@export var damage : int
@export var Closest : Node

func _ready() -> void:
	Oponent = get_tree().get_nodes_in_group("ENEMY")
	Player_id = randi_range(0, Oponent.size()-1)
	Player = Oponent[Player_id]
	
	var material = get_node("Shadow").material_override
	match(Player_id):
		0 : material.albedo_color = Color.WHITE
		1 : material.albedo_color = Color.BLUE
		2 : material.albedo_color = Color.RED
		3 : material.albedo_color = Color.WEB_GREEN
	
	
	for i in Oponent:
		i.collision_layer = 4
		i.collision_mask = 2 | 8 | 16
		
	


func HITSTOP():
	$HitStop.start(0.05)
	PAUSE.call_deferred()
	
func PAUSE():
	self.process_mode = Node.PROCESS_MODE_DISABLED
	
func UNPAUSE():
	self.process_mode = Node.PROCESS_MODE_INHERIT


func _on_hit_stop_timeout() -> void:
	UNPAUSE()
