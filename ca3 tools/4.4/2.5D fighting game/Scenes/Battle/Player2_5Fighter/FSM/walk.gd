extends Node

@export var walk_speed :  float


func Update(delta):
	
	if %FSM.Root.IsAI:
		UpdateAI(delta)
	else:
		if %FSM.Root.IsP1:
			P1Motion()
			P1Attacks()
		



func P1Attacks():
	
	var button = %Transition.GetButton()
	if button == "A":
		%FSM.current = %FSM.get_node("ATTACK")
		%FSM.current.Start("KICK")


func P1Motion():
		var dir = Vector2i.ZERO
		dir = %Transition.GetKeys()
		%FSM.raw_dir = dir
		if Input.is_action_pressed("B"):
			%FSM.current = %FSM.get_node("DASH")
			%FSM.current.Start()
			return
		if Input.is_action_pressed("DOWN"):
			%FSM.current = %FSM.get_node("CROUCH")
			%FSM.current.Start()
			return
		if Input.is_action_just_released("UP"):
			%FSM.current = %FSM.get_node("JUMP")
			%FSM.current.Start(%FSM.dir)
			return
		UpdateP1(dir)


func UpdateP1(dir):
	
	if dir != Vector2i.ZERO:
		if dir.x < 0 and %FSM.dir.x > 0:
			%TurnAroundTimer.start(%TurnAround.time)
			%FSM.dir.x = dir.x
			%FSM.current = %FSM.get_node("TurnAround")
			return
		if dir.x > 0 and %FSM.dir.x < 0:
			%TurnAroundTimer.start(%TurnAround.time)
			%FSM.dir.x = dir.x
			%FSM.current = %FSM.get_node("TurnAround")
			return
	if %FSM.raw_dir.x == 0:
		%FSM.current = %FSM.get_node("IDLE")
		%FSM.current.Start()
		
func Start():
	%FSM.state.travel("WALKING")
	

func Physics(delta):
	
	if %FSM.Root.IsAI:
		if %Target.goal == %Target.goal_type.keepaway:
			var speed = delta * %FSM.dir_ai * walk_speed
			var colision = %FSM.Root.move_and_collide(Vector3(-speed.x, speed.y, 0))
			if colision:
				if colision.get_collider().is_in_group("WALL"):
					%TurnAroundTimer.start(%TurnAround.time)
					%FSM.dir_ai.x = %FSM.raw_dir_ai.x
					%FSM.current = %FSM.get_node("TurnAround")
		else:
			var speed = delta * %FSM.dir_ai * walk_speed
			var colision = %FSM.Root.move_and_collide(Vector3(speed.x, speed.y, 0))
			if colision:
				if colision.get_collider().is_in_group("WALL"):
					%TurnAroundTimer.start(%TurnAround.time)
					%FSM.dir_ai.x = %FSM.raw_dir_ai.x
					%FSM.current = %FSM.get_node("TurnAround")
	else:
		var speed = delta * %FSM.dir * walk_speed
		%FSM.Root.move_and_collide(Vector3(speed.x, speed.y, 0))



func UpdateAI(delta):
	
	if %Target.goal == %Target.goal_type.punch and %GetDistance.current_distance <= %GetDistance.distance_type.melee:
		%FSM.current = %FSM.get_node("ATTACK")
		%FSM.current.Start("KICK")
		return
	if %Mood.current_mood == %Mood.mood.idle:
		%Target.goal = %Target.goal_type.wait
		%FSM.current = %FSM.get_node("IDLE")
		%FSM.current.Start()
		return
	if %Target.goal == %Target.goal_type.jump_v:
		%FSM.current = %FSM.get_node("JUMP")
		%FSM.current.Start(Vector2i.ZERO)
		%Target.goal = %Target.goal_type.wait
	if %Target.goal == %Target.goal_type.jump_f:
		%FSM.current = %FSM.get_node("JUMP")
		%FSM.current.Start(%FSM.dir)
		%Target.goal = %Target.goal_type.wait
	if %Target.goal == %Target.goal_type.jump_b:
		%FSM.current = %FSM.get_node("JUMP")
		%Target.goal = %Target.goal_type.wait
		%FSM.current.Start(Vector2i(-%FSM.dir.x, %FSM.dir.y))
	if %Target.goal == %Target.goal_type.chase or  %Target.goal == %Target.goal_type.keepaway:
		if  %Target.goal == %Target.goal_type.chase:
			if %FSM.dir_ai.x > 0 and %FSM.raw_dir_ai.x < 0:
				%TurnAroundTimer.start(%TurnAround.time)
				%FSM.dir_ai.x = %FSM.raw_dir_ai.x
				%FSM.current = %FSM.get_node("TurnAround")
				%Target.goal = %Target.goal_type.wait
				return
			if %FSM.dir_ai.x < 0 and %FSM.raw_dir_ai.x > 0:
				%TurnAroundTimer.start(%TurnAround.time)
				%FSM.dir_ai.x = %FSM.raw_dir_ai.x
				%FSM.current = %FSM.get_node("TurnAround")
				%Target.goal = %Target.goal_type.wait
				return
	else:
		%FSM.current = %FSM.get_node("IDLE")
		%FSM.current.Start()
	if %GetDistance.current_distance < %GetDistance.distance_type.melee:
		%FSM.current = %FSM.get_node("IDLE")
		%FSM.current.Start()
