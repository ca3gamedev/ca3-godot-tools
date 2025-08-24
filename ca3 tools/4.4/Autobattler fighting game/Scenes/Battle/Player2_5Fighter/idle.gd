extends Node

func Update(delta):
	
	if not %FSM.OnGround:
		%FSM.current = %FSM.get_node("FALL")
		if %FSM.Root.IsAI:
			%FSM.current.Start(%FSM.dir_ai.x)
		else:
			%FSM.current.Start(%FSM.dir.x)
	
	
	if not  %FSM.Root.IsAI:
		if %FSM.Root.IsP1:
			P1Attacks()
			P1Motion()
	else:
		UpdateAI(delta)
	

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
		%FSM.current.Start(dir)
		return
	UpdateP1(dir)
		
	
func UpdateP1(dir):
	
	if dir != Vector2i.ZERO:
		if dir.x == %FSM.dir.x:
			%FSM.current = %FSM.get_node("WALK")
			%FSM.current.Start()
			return
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

func Start():
	%FSM.state.travel("IDLE")
	
	if %FSM.Root.IsAI:
		if %FSM.raw_dir_ai.x != %FSM.dir_ai.x and not %TurnAround.delay:
			%TurnAround.delay = true
			$"../TurnAround/DelayTurnAI".start(2)
			%TurnAroundTimer.start(%TurnAround.time)
			%FSM.current = %FSM.get_node("TurnAround")

func UpdateAI(delta):
	
	if %Target.goal == %Target.goal_type.punch and %GetDistance.current_distance <= %GetDistance.distance_type.melee:
		%FSM.current = %FSM.get_node("ATTACK")
		%FSM.current.Start("KICK")
		return
	if %Target.goal == %Target.goal_type.jump_v:
		%FSM.current = %FSM.get_node("JUMP")
		%FSM.current.Start(%FSM.dir_ai)
	if %Target.goal == %Target.goal_type.jump_f:
		%FSM.current = %FSM.get_node("JUMP")
		%FSM.current.Start(%FSM.dir_ai)
	if %Target.goal == %Target.goal_type.jump_b:
		%FSM.current = %FSM.get_node("JUMP")
		%FSM.current.Start(Vector2i(-%FSM.dir_ai.x, %FSM.dir_ai.y))
	if %Target.goal == %Target.goal_type.chase:
		if %GetDistance.current_distance > %GetDistance.distance_type.melee:
			%FSM.current = %FSM.get_node("WALK")
			%FSM.current.Start()
	if  %Target.goal == %Target.goal_type.keepaway:
		%FSM.current = %FSM.get_node("WALK")
		%FSM.current.Start()
