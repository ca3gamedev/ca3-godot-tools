extends Node

@export var ismovement : bool = false
#ID of the attack on the animationTree
@export var attack_id : float
#Time for the hitstop to last
@export var attack_hitstun : float
#Strenght of the camera shake
@export var shake_strenght : float
#Speed of the delta lerp to end up the shake (bigger number means shorter time of shake)
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

func Update(delta):
	%Code.CodeUpdate(delta)

func Start():
	%Hitbox.hitstun = attack_hitstun
	%Hitbox.shakestrenght = shake_strenght
	%Hitbox.shake_speed = shake_speed
	%Anim.set("parameters/conditions/attack", true)
	%Anim.set("parameters/ATTACK/blend_position", attack_id * %Transitions.motion)
	
	
