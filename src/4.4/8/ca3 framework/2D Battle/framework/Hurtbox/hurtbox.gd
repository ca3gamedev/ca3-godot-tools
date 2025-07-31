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
		Music.Slash()
		%Hitbox.ENEMYHIT()
		HIT()
		area.get_parent().queue_free()
	
	if area.is_in_group("ENEMY_FIREBALL"):
		Music.HIT()
		area.HIT()
		VariableNodes.enemy_damage = (VariableNodes.Level / 3) * 3 + 5
		%Hitbox.ENEMYHIT()
		VariableNodes.MyCamera2D.Shake(%Hitbox.shakestrenght, %Hitbox.shake_speed)
		get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
	
