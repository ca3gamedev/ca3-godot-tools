extends Node

var mode = "Hurtbox Pos"

func _process(delta):
	
	if %SetAnim.focused:
		return
	
	if Input.is_action_just_released("HitboxPos"):
		mode = "Hitbox Pos"
		%LOG.text = mode
		%Tabs.current_tab = 0
	if Input.is_action_just_released("HurtboxPos"):
		mode = "Hurtbox Pos"
		%LOG.text = mode
		%Tabs.current_tab = 1
	if Input.is_action_just_released("FireballPos"):
		mode = "Fireball Pos"
		%LOG.text = mode
		%Tabs.current_tab = 2

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		match(mode):
			"Hitbox Pos" : 
				var pos = %Center.to_local(%Center.get_global_mouse_position())
				%Hitbox.position = pos
			"Hurtbox Pos" :
				var pos = %Center.to_local(%Center.get_global_mouse_position())
				%Hurtbox.position = pos
			"Fireball Pos" :
				var pos = %Center.to_local(%Center.get_global_mouse_position())
				%Fireball.position = pos
	
	if Input.is_action_just_released("SetFrame"):
		%CreateFrame.CreateFrame(mode, %Load.anim_selected, %FramesSelection.frame, Vector2i.ZERO)
	
func Update():
	var ani = %Load.anim_selected
	%HitboxPosData.clear()
	for i in %Data.hitbox_pos[ani]:
		if typeof(i) == TYPE_VECTOR4I :
			%HitboxPosData.add_item(str(i))
	%HitboxSizeData.clear()
	for i in %Data.hitbox_size[ani]:
		if typeof(i) == TYPE_VECTOR4I :
			%HitboxSizeData.add_item(str(i))
	%HurtboxPosData.clear()
	for i in %Data.hurtbox_pos[ani]:
		if typeof(i) == TYPE_VECTOR4I :
			%HurtboxPosData.add_item(str(i))
	%HurtboxSizeData.clear()
	for i in %Data.hurtbox_size[ani]:
		if typeof(i) == TYPE_VECTOR4I :
			%HurtboxSizeData.add_item(str(i))
	%FireballPosData.clear()
	for i in %Data.fireball_pos[ani]:
		if typeof(i) == TYPE_VECTOR4I :
			%FireballPosData.add_item(str(i))


func _on_tab_container_tab_selected(tab):
	match(tab):
		0 :
			mode = "Hitbox Pos"
			%LOG.text = mode
		1 :
			mode = "Hurtbox Pos"
			%LOG.text = mode
		2 :
			mode = "Fireball Pos"
			%LOG.text = mode

func UpdateHitboxes():
	var ani = %Load.anim_selected
	if len(%Data.hitbox_pos[ani]) > 1:
		var frame = %FramesSelection.frame
		var id = -999
		var last = 0
		var pos = Vector2i.ZERO
		for i in len(%Data.hitbox_pos[ani]):
			if typeof(%Data.hitbox_pos[ani][i]) != TYPE_STRING :
				if %Data.hitbox_pos[ani][i].z > last and %Data.hitbox_pos[ani][i].z < frame:
					last = i
				if %Data.hitbox_pos[ani][i].z == frame:
					id = i
					break
		if id == -999:
			if typeof(%Data.hitbox_pos[ani][last]) == TYPE_VECTOR4I:
				pos = Vector2i(%Data.hitbox_pos[ani][last].x, %Data.hitbox_pos[ani][last].y)
		else:
			pos = Vector2i(%Data.hitbox_pos[ani][id].x, %Data.hitbox_pos[ani][id].y)
		%Hitbox.position = pos
	
	if len(%Data.hurtbox_pos[ani]) > 1:
		var frame = %FramesSelection.frame
		var id = -999
		var last = 0
		var pos = Vector2i.ZERO
		for i in len(%Data.hurtbox_pos[ani]):
			if typeof(%Data.hurtbox_pos[ani][i]) != TYPE_STRING :
				if %Data.hurtbox_pos[ani][i].z > last and %Data.hurtbox_pos[ani][i].z < frame:
					last = i
				if %Data.hurtbox_pos[ani][i].z == frame:
					id = i
					break
		if id == -999:
			if typeof(%Data.hurtbox_pos[ani][last]) == TYPE_VECTOR4I:
				pos = Vector2i(%Data.hurtbox_pos[ani][last].x, %Data.hurtbox_pos[ani][last].y)
		else:
			pos = Vector2i(%Data.hurtbox_pos[ani][id].x, %Data.hurtbox_pos[ani][id].y)
		%Hurtbox.position = pos
	
	if len(%Data.fireball_pos[ani]) > 1:
		var frame = %FramesSelection.frame
		var id = -999
		var last = 0
		var pos = Vector2i.ZERO
		for i in len(%Data.fireball_pos[ani]):
			if typeof(%Data.fireball_pos[ani][i]) != TYPE_STRING :
				if %Data.fireball_pos[ani][i].z > last and %Data.fireball_pos[ani][i].z < frame:
					last = i
				if %Data.fireball_pos[ani][i].z == frame:
					id = i
					break
		if id == -999:
			if typeof(%Data.fireball_pos[ani][last]) == TYPE_VECTOR4I:
				pos = Vector2i(%Data.fireball_pos[ani][last].x, %Data.fireball_pos[ani][last].y)
		else:
			pos = Vector2i(%Data.fireball_pos[ani][id].x, %Data.fireball_pos[ani][id].y)
		%Fireball.position = pos
