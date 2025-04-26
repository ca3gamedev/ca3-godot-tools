extends Node


func LoadAllHitboxAnimations():
	
	var animations = %NextPreviousHitbox.AttackHitboxPlayer.get_animation_list()
	%HitboxAnimations.clear()
	for i in animations:
		%HitboxAnimations.add_item(i)
