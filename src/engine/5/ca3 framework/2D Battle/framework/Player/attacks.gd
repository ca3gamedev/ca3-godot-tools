extends Node

@export var futurecancelname : String
@export var futurestrenght : int

var Anim

func _ready():
	await get_tree().process_frame
	Anim = $"../..".Anim

func ChangeState():
	%Transitions.ChangeMotion(futurecancelname, futurestrenght)

func GetInputStrenghtType(cancel_input):
	
	for i in get_children():
		if typeof(cancel_input) == TYPE_STRING:
			if i.specialname == cancel_input or i.specialnameL == cancel_input or i.specialnameR == cancel_input:
				return i.attackstrenght
		elif typeof(cancel_input) == TYPE_ARRAY:
			if i.buttonname == cancel_input[0]:
				if i.motioninput == cancel_input[1]:
					return i.attackstrenght
	return get_child(0).attack_strenght.WEAK

func SetFutureCancel(cancel_input):
	for i in get_children():
		if typeof(cancel_input) == TYPE_STRING:
			if i.specialname == cancel_input or i.specialnameL == cancel_input or i.specialnameR == cancel_input:
				futurecancelname = i.name
				futurestrenght = i.attackstrenght
		elif typeof(cancel_input) == TYPE_ARRAY:
			if i.buttonname == cancel_input[0]:
				if i.motioninput == cancel_input[1]:
					futurecancelname = i.name
					futurestrenght = i.attackstrenght
	


func GetCurrentStrenght():
	if %Transitions.currentanim.name != "IDLE" or %Transitions.currentanim.name != "WALK" or %Transitions.currentanim.name != "DASH":
		return %Transitions.currentanim.attackstrenght
	return 0
