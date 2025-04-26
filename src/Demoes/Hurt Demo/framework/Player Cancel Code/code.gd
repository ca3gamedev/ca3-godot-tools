extends Node

@export var cancel_window : bool
@export var cancel_time : float
var cancel_input = "none"
@export var anim : AnimatedSprite2D

func _ready():
	await get_tree().process_frame
	anim = %Sprites.get_node("SpriteSheet")

func _process(delta):
	
	#CANCEL WITH STRING OF SPECIAL INPUT
	if typeof(cancel_input) == TYPE_STRING:
		if cancel_input != "none":
			if %ATTACKS.GetInputStrenghtType(cancel_input) > %ATTACKS.GetCurrentStrenght():
				%ATTACKS.SetFutureCancel(cancel_input)
				%ATTACKS.ChangeState()
				cancel_input = "none"
	
	
	# WALK SAKURAI CANCEL
	if %Transitions.currentanim.walkcancel:
		if anim.frame > %Transitions.currentanim.cancelframe:
			%Transitions.get_node("Motion Transition").GetRawMotion()
			if %Transitions.rawmotion != Vector2i.ZERO:
				%Transitions.ChangeMotion("WALK", -888)

	
func HIT():
	if %Transitions.currentanim.cancel:
		cancel_window = true
		%CancelWindow.start(cancel_time)

func DashCancel():
	%Transitions.ReturntoIdle()


func _on_cancel_window_timeout():
	cancel_window = false
	if %INPUT.GetInput() != null:
		cancel_input = %INPUT.GetInput()
	
