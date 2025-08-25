extends Node


func _on_ani_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "IDLE" or anim_name == "JUMP" or anim_name == "Jump F" or anim_name == "WALKING":
		return
	if anim_name == "CROUCHED" or anim_name == "RUN":
		return

	
	%FSM.current = %FSM.get_node("IDLE")
	%FSM.current.Start()
