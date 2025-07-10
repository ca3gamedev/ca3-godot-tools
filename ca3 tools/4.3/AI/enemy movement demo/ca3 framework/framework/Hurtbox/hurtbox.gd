extends Area2D

@export var Transition : Node
@export var is_AI : bool
@export var is_fireball : bool

func _ready():
	Transition = %Transitions

func HIT():
	Transition.ChangeMotion("WEAK HURT", -999)
	%HitstopFreeze.start(0.2)

func GetID():
	return $"../".PlayerID


func _on_area_entered(area):
	
	if area.is_in_group("FIREBALL"):
		%Hitbox.ENEMYHIT()
		HIT()
		area.get_parent().queue_free()
