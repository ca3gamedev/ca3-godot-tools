extends Node

@export var dash_speed :  float

func Update(delta):
	
	if not Input.is_action_pressed("B"):
		%FSM.current = %FSM.get_node("IDLE")
		%FSM.current.Start()


func Start():
	%FSM.state.travel("DASH")


func Physics(delta):
	
	var speed = delta * %FSM.dir * dash_speed
	%FSM.Root.move_and_collide(Vector3(speed.x, speed.y, 0))
