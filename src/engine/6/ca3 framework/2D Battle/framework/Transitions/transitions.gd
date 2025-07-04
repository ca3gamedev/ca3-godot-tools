extends Node

var motion = Vector2i.DOWN
var rawmotion = Vector2i.DOWN
var specialinput = "none"
var rawspecialinput = "none"

@export var currentmotion : Node
@export var inputnode : Node
@export var currentanim : Node
@export var motionparent : Node
@export var motionanimtree : Node
@export var transitionnode : Node
@export var DashLenght : float
@export var CurrentStrenght : int

var flicker_check = 0
var currentstate = "IDLE"

func _process(delta):
	
	if flicker_check < 5:
		flicker_check += delta
	
	transitionnode.Update()
	currentanim.Update(delta)

func _physics_process(delta):
	currentmotion.Physics(delta)

func ChangeMotion(state, strenght):
	
	# -888 simply is a dummy value that means the flicker check doesnt
	# apply in some cancels
	if flicker_check < 0.15 and strenght != -888:
		# This double checks if the state is movement and avoid flickering
		return
	
	# -999 is the value to override CurrentStenght and used for things
	# like return to idle function
	if strenght != -999:
		#This helps to avoid canceling from super into weak normal
		if CurrentStrenght > strenght:
			return
	else:
		CurrentStrenght = strenght
	
	match(state):
		"IDLE" : 
			%Hitbox.get_node("CollisionShape2D").disabled = true
			flicker_check = 0
			currentmotion = motionparent.get_node("IDLE")
			currentanim = motionanimtree.get_node("IDLE")
			transitionnode = get_node("IDLE")
		"WALK" : 
			%Hitbox.get_node("CollisionShape2D").disabled = true
			flicker_check = 0
			currentmotion = motionparent.get_node("WALK")
			currentanim = motionanimtree.get_node("WALK")
			transitionnode = get_node("WALK")
		"DASH" : 
			%Hitbox.get_node("CollisionShape2D").disabled = true
			flicker_check = 0
			currentmotion = motionparent.get_node("DASH")
			currentanim = motionanimtree.get_node("DASH")
			transitionnode = get_node("DASH")
		"JRPG DASH" :
			ClearInput()
			%Hitbox.get_node("CollisionShape2D").disabled = true
			flicker_check = 0
			currentmotion = motionparent.get_node("DASH")
			currentanim = motionanimtree.get_node("DASH")
			transitionnode = get_node("DASH")
		"PUNCH" :
			flicker_check = 0
			currentmotion = motionparent.get_node("IDLE")
			currentanim = %ATTACKS.get_node("PUNCH")
			currentanim.Start()
			CurrentStrenght = strenght
		"HADOUKEN" :
			if VariableNodes.Mana > 99:
				flicker_check = 0
				currentmotion = motionparent.get_node("IDLE")
				currentanim = %ATTACKS.get_node("HADOUKEN")
				currentanim.Start()
				CurrentStrenght = strenght
		"GALACTICA" :
			flicker_check = 0
			currentmotion = motionparent.get_node("IDLE")
			currentanim = %ATTACKS.get_node("GALACTICA")
			currentanim.Start()
			specialinput = "none"
			rawspecialinput = "none"
			CurrentStrenght = strenght
		"WEAK HURT" :
			flicker_check = 0
			$"..".velocity = Vector2.ZERO
			currentmotion = motionparent.get_node("IDLE")
			currentanim = %HURTS.get_node("WEAKHURT")
			currentanim.Start()

func IsIdle():
	if flicker_check > 0.4:
		if GetState() == "IDLE":
			return true
	return false

func IsIdleDash():
	#This control the lenght of the dash if released, not if hold
	if flicker_check > DashLenght:
		if rawspecialinput == "none" or rawspecialinput == "IDLE":
			return true
	return false

func GetState():

	if specialinput != "none":
		return specialinput
	else:
		if rawspecialinput == "WALK":
			return "WALK"
		else:
			return "IDLE"

func ClearInput():
	specialinput = "none"

func ReturntoIdle():
	CurrentStrenght = -999
	ClearInput()
	ChangeMotion("IDLE", -999)


func EndAnimations():
	$"../".Anim.set("parameters/conditions/attack", false)
	$"../".Anim.set("parameters/conditions/Hurt", false)
	%Code.fireball_id = 0
	%FireballDelay.fireballshoot = 0
	specialinput = "none"
	ReturntoIdle()
