extends Node

func CreateFrame(mode, ani, frame, angle):
	
	
	if ani == -999:
		return
	
#	var ani = %Load.anim_selected
	match(mode):
		"Hitbox Pos" : 
			var pos = %Hitbox.position
			
			
			if angle != Vector2i.ZERO:
				if angle.x == 0:
					pos.x = 0
				if angle.x > 0 and pos.x < 0:
					pos.x *= -1
				if angle.y == 0:
					pos.y = 0
				if angle.y < 0 and pos.y > 0:
					pos.y = -pos.y
				if angle.x == -1:
					pos.x = -pos.x
				if angle.y == -1:
					pos.y = -pos.y
			
			var id = -999
			for i in len(%Data.hitbox_pos[ani]):
				if typeof(%Data.hitbox_pos[ani][i]) == TYPE_VECTOR4I:
					if %Data.hitbox_pos[ani][i].z == frame:
						id = i
			if id == -999:
				%Data.hitbox_pos[ani].append(Vector4i(pos.x, pos.y, frame, 0))
			else:
				%Data.hitbox_pos[ani][id] = Vector4i(pos.x, pos.y, frame,0)
		"Hurtbox Pos" :
			var pos = %Hurtbox.position
			
			if angle.x != 0:
				pos.x *= -1
			if angle.y != 0:
				pos.y *= -1
			
			var id = -999
			for i in len(%Data.hurtbox_pos[ani]):
				if typeof(%Data.hurtbox_pos[ani][i]) == TYPE_VECTOR4I:
					if %Data.hurtbox_pos[ani][i].z == frame:
						id = i
			if id == -999:
				%Data.hurtbox_pos[ani].append(Vector4i(pos.x, pos.y, frame, 0))
			else:
				%Data.hurtbox_pos[ani][id] = Vector4i(pos.x, pos.y, frame, 0)
		"Fireball Pos" :
			var pos = %Fireball.position
			
			if angle.x != 0:
				pos.x *= -1
			if angle.y != 0:
				pos.y *= -1
			
			var id = -999
			for i in len(%Data.fireball_pos[ani]):
				if typeof(%Data.fireball_pos[ani][i]) == TYPE_VECTOR4I:
					if %Data.fireball_pos[ani][i].z == frame:
						id = i
			if id == -999:
				%Data.fireball_pos[ani].append(Vector4i(pos.x, pos.y, frame, 0))
			else:
				%Data.fireball_pos[ani][id] = Vector4i(pos.x, pos.y, frame, 0)
	%Mouse.Update()
