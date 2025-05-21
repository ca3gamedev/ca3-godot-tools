extends Node

# THE HITBOX I USE TO SAVE LATER
# THESE ARE THE HITBOX PLAYER I USE TO SET UP THE ANIMATIONS TO SAVE LATER
@export var AttackHitboxPlayer : AnimationPlayer
@export var AttackHitboxTree : AnimationTree
@export var HurtboxPlayer : AnimationPlayer
@export var HurtboxTree : AnimationTree

@export var current_hitbox : int = 0
@export var max_frames : int = 0
@export var current_index : int = 0
@export var current_anim : String = ""

func _on_select_hitbox_pressed():
	current_anim = %HitboxAnimations.get_item_text(current_index)
	%SelectedAnimLOG.text = current_anim
	AttackHitboxPlayer.play(current_anim)
	AttackHitboxPlayer.stop()
	current_hitbox = 0
	
	%Load.LOADNODEATTACKBOX()
