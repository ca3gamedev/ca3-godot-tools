extends Node

var motion = Vector2i.ZERO
var rawmotion = Vector2i.ZERO
var specialinput = "none"
var rawspecialinput = "none"

@export var currentmotion : Node
@export var inputnode : Node
@export var currentanim : Node
@export var motionparent : Node
@export var motionanimtree : Node
@export var transitionnode : Node

var flicker_check = 0
var currentstate = "IDLE"

func _process(delta):
	
	$"Motion Transition".GetMotion()
	
	if flicker_check < 5:
		flicker_check += delta
	
	transitionnode.Update()
	currentanim.UpdateAnim()

func _physics_process(delta):
	currentmotion.Physics(delta)

func ChangeMotion(state):
	match(state):
		"IDLE" : 
			flicker_check = 0
			currentmotion = motionparent.get_node("IDLE")
			currentanim = motionanimtree.get_node("IDLE")
			transitionnode = get_node("IDLE")
		"WALK" : 
			flicker_check = 0
			currentmotion = motionparent.get_node("WALK")
			currentanim = motionanimtree.get_node("WALK")
			transitionnode = get_node("WALK")
		"DASH" : 
			flicker_check = 0
			currentmotion = motionparent.get_node("DASH")
			currentanim = motionanimtree.get_node("DASH")
			transitionnode = get_node("DASH")
		"JRPG DASH" :
			flicker_check = 0
			currentmotion = motionparent.get_node("DASH")
			currentanim = motionanimtree.get_node("DASH")
			transitionnode = get_node("DASH")

func IsIdle():
	if flicker_check > 0.4:
		if GetState() == "IDLE":
			return true
	return false

func IsIdleDash():
	if flicker_check > 0.5 and rawspecialinput == "none":
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
