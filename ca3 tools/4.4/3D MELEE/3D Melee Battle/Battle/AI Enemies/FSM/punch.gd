extends Node

@onready var Root = $"../.."
@export var close : float
@export var close_timer : float

func _process(delta):
	
	if Variables.Player3D.global_position.distance_to(Root.global_position) < 2:
		close += delta
		
		if close > close_timer:
			close = 0.0
			close_timer = randf_range(1.0, 6.0)
			%FSM.current = %FSM.get_node("PUNCH")
			%FSM.state_machine.travel("KICK")

func Update(delta):
	pass

func Physics(delta):
	Root.velocity = Vector3.ZERO
	Root.move_and_slide()
