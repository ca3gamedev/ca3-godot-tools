extends Node

@export var dir : Vector2i
@export var button : String = "none"

func _ready():
	Update()

func Update():
	%SelectedDoubleTap.text = str(dir)
	%SelectedDoubleTapButton.text = button


func _on_none_2_pressed():
	dir = Vector2i.ZERO
	Update()


func _on_left_pressed():
	dir = Vector2i.LEFT
	Update()


func _on_down_pressed():
	dir = Vector2i.DOWN
	Update()


func _on_right_pressed():
	dir = Vector2i.RIGHT
	Update()


func _on_up_pressed():
	dir = Vector2i.UP
	Update()


func _on_nonebutton_pressed():
	button = "none"
	Update()


func _on_up_left_pressed():
	dir = Vector2i(-1, -1)
	Update()


func _on_down_left_pressed():
	dir = Vector2i(-1, 1)
	Update()


func _on_down_right_pressed():
	dir = Vector2i(1, 1)
	Update()


func _on_up_right_pressed():
	dir = Vector2i(1, -1)
	Update()


func _on_a_pressed():
	button = "A"
	Update()


func _on_b_pressed():
	button = "B"
	Update()



func _on_c_pressed():
	button = "C"
	Update()


func _on_d_pressed():
	button = "D"
	Update()


func _on_x_pressed():
	button = "X"
	Update()


func _on_y_pressed():
	button = "Y"
	Update()


func _on_z_pressed():
	button = "Z"
	Update()


func _on_w_pressed():
	button = "W"
	Update()


func _on_add_double_tap_pressed():
	%AddSkillButtons.AddSkill("double tap", dir, button)
	%SkillLOG.text = "added input"


func _on_add_charge_pressed():
	
	if button != "none":
		%AddSkillButtons.AddSkill("charge", dir.x, button)
		%SkillLOG.text = "added input"
	else:
		%SkillLOG.text = "no button selected"


func _on_hadouken_pressed():
	
	if button != "none" and dir.x != 0:
		%AddSkillButtons.AddSkill("hadouken", dir.x, button)
		%SkillLOG.text = "added input"
	else:
		%SkillLOG.text = "no direction selected or no button selected"


func _on_dragon_punch_pressed():
	
	if button != "none" and dir.x != 0:
		%AddSkillButtons.AddSkill("dragon punch", dir.x, button)
		%SkillLOG.text = "added input"
	else:
		%SkillLOG.text = "no direction selected or no button selected"


func _on_half_circle_pressed():
	
	if button != "none" and dir.x != 0:
		%AddSkillButtons.AddSkill("hadouken", dir.x, button)
		%SkillLOG.text = "added input"
	else:
		%SkillLOG.text = "no direction selected or no button selected"


func _on_double_hadouken_pressed():
	
	if button != "none" and dir.x != 0:
		%AddSkillButtons.AddSkill("double hadouken", dir.x, button)
		%SkillLOG.text = "added input"
	else:
		%SkillLOG.text = "no direction selected or no button selected"


func _on_parry_pressed():
	
	if dir.x != 0:
		%AddSkillButtons.AddSkill("parry", dir.x, button)
		%SkillLOG.text = "added input"
	else:
		%SkillLOG.text = "no direction selected"


func _on_mash_pressed():
	
	if button != "none":
		%AddSkillButtons.AddSkill("mash", dir.x, button)
		%SkillLOG.text = "added input"
	else:
		%SkillLOG.text = "no button selected"
