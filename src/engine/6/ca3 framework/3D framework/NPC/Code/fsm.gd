extends Node

@export var current : Node
@export var rate_change : float
@export var idle : bool
@export var dir : Vector2

func _ready():
	rate_change = randf_range(0.5, 1.5)
	$"../Walk".start(rate_change)

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)



func _on_walk_timeout():
	
	idle  = !idle
	
	if idle:
		current = $IDLE
		$"../Walk".start(rate_change*2.5)
	else:
		var x = randf_range(-1, 1)
		var y = randf_range(-1, 1)
		if randi_range(0, 10) > 3:
			var tmp = (VariableNodes.Player1_3D.global_position - $"..".global_position).normalized()
			dir = Vector2(tmp.x, tmp.y)
		else:
			dir = Vector2(x, y)
		current = $WALK
		$"../Walk".start(rate_change*1.5)
