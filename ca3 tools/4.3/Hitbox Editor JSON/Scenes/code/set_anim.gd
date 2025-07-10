extends Node

@export var focused = false
@export var selected_animation = ""


func _on_anim_name_focus_exited():
	focused = false


func _on_anim_name_focus_entered():
	focused = true


func _on_set_anim_pressed():
	selected_animation = %AnimName.text
	%"Anim LOG".text = selected_animation


func AddOrtho(type):
	AddFrame("_BACK_LEFT_", type, Vector2i(-1, -1))
	AddFrame("_BACK_RIGHT_", type, Vector2i(1, -1))
	AddFrame("_FRONT_LEFT_", type, Vector2i(-1, 1))
	AddFrame("_FRONT_RIGHT_", type, Vector2i(1, 1))
	
func AddDiagonals(type):
	AddFrame("_FRONT_", type, Vector2i(0, 1))
	AddFrame("_BACK_", type, Vector2i(0, -1))
	AddFrame("_LEFT_", type, Vector2i(-1, 0))
	AddFrame("_RIGHT_", type, Vector2i(1, 0))
	

func AddFrame(myname, type, angle):
	CreateFrame(selected_animation + myname, type, angle)

func CreateFrame(myname, type, angle):
	match(type):
		"Hitbox Pos" : %CreateFrame.CreateFrame(type, GetIdAnim(myname, %Data.hitbox_pos), %FramesSelection.frame, angle)
		"Hurtbox Pos" : %CreateFrame.CreateFrame(type, GetIdAnim(myname, %Data.hurtbox_pos), %FramesSelection.frame, angle)
		"Fireball Pos" : %CreateFrame.CreateFrame(type, GetIdAnim(myname, %Data.fireball_pos), %FramesSelection.frame, angle)


func GetIdAnim(myname, type):	
	for i in len(type):
		if typeof(type[i][0]) == TYPE_STRING and type[i][0] == myname:
			return i
	return -999


func _on_set_8_frames_pressed():
	
	if selected_animation == "":
		%LOG.text = "ANIMATION NOT SELECTED"
		return
	
	var type = %Mouse.mode
	AddOrtho(type)
	AddDiagonals(type)
