extends Node

@export var cancel : bool
@export var dashcancel : bool
@export var dashcancelframe : float
@export var fireball : bool
@export var movement : Vector2
@export var throw : bool
@export var airblock : bool
@export var attacktype : attack_type
@export var attackstrenght : attack_strenght
@export var guardtype : guard_type

enum attack_type {STANDING, CROUCHING, AIR}
enum attack_strenght {WEAK, MID, STRONG, SPECIAL, EX, SUPER, DOUBLESUPER}
enum guard_type {NORMAL, LOW, UNBLOCKABLE}



func Update():
	pass
