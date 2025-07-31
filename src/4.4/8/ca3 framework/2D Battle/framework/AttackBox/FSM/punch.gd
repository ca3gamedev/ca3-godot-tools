extends Node

@export var damage : int
@export var ismovement : bool = false
#ID of the attack on the animationTree
@export var attack_id : float
#Time for the hitstop to last
@export var attack_hitstun : float
#Strenght of the camera shake
@export var shake_strenght : float
#Speed of the delta lerp to end up the shake (bigger number means shorter time of shake)
@export var distance_attack : float
@export var frame_attack : int
@export var shake_speed : float
@export var specialname : String
@export var specialnameL : String
@export var specialnameR : String
@export var buttonname : String
@export var motioninput : String
@export var cancel : bool
@export var dashcancel : bool
@export var walkcancel : bool
@export var cancelframe : int
@export var fireballframe : int
@export var FireballDelay : float
@export var fireballoffset : Vector2i
@export var fireballlinearangle : Vector2
@export var fireballspeed : float
@export var fireball : bool
@export var fireballscene : PackedScene
@export var throw : bool
@export var airblock : bool
@export var attacktype : attack_type
@export var attackstrenght : attack_strenght
@export var guardtype : guard_type

enum attack_type {STANDING, CROUCHING, AIR}
enum attack_strenght {WEAK, MID, STRONG, SPECIAL, EX, SUPER, DOUBLESUPER}
enum guard_type {NORMAL, LOW, UNBLOCKABLE}

var Anim

func _ready():
	await get_tree().process_frame
	%Hitbox.get_node("CollisionShape2D").disabled = true
	Anim = $"../../..".Anim

func Update(delta):
	%Code.CodeUpdate(delta)
	if frame_attack == $"../../..".SpriteSheet.frame:
		%Hitbox.get_node("CollisionShape2D").disabled = false
	else:
		%Hitbox.get_node("CollisionShape2D").disabled = true
	
	if fireball and %FireballDelay.fireballshoot == 0 and %FireballDelay.idle and frame_attack == $"../../..".SpriteSheet.frame:
		VariableNodes.ConsumeStock()
		%FireballDelay.fireballshoot += 1
		VariableNodes.PlayerBulletManager.SpawnLinear(Vector2i($"../../../".global_position), %Transitions.currentanim.fireballscene, %Transitions.currentanim.fireballspeed, %Transitions.motion, distance_attack * %Transitions.motion * 1.5)
		%FireballDelay.idle = false
		%FireballDelay.start(FireballDelay)

func Start():
	VariableNodes.AddMana()
	VariableNodes.player_damage = damage
	%Hitbox.hitstun = attack_hitstun
	%Hitbox.shakestrenght = shake_strenght
	%Hitbox.shake_speed = shake_speed
	Anim.set("parameters/conditions/attack", true)
	Anim.set("parameters/ATTACK/blend_position", attack_id * %Transitions.motion)
	%Hitbox.position = distance_attack * %Transitions.motion
