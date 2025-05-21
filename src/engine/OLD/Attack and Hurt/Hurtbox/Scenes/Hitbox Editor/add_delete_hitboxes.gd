extends Node

func _ready():
	
	await  get_tree().process_frame
	await  get_tree().process_frame
	await  get_tree().process_frame
	
	CreateEmptyHitboxAnimations()
	$"../../HiboxAnimationsCode".LoadAllHitboxAnimations()

func CreateEmptyHitboxAnimations():
	
	var state_machine = %Load.PlayerAnimTree.tree_root
	var hitbox_state_machine = %NextPreviousHitbox.AttackHitboxTree.tree_root
	
	AddEmptyAnimations("MOVE", state_machine, hitbox_state_machine)
	AddEmptyAnimations("ATTACK", state_machine, hitbox_state_machine)
	AddEmptyAnimations("HURT", state_machine, hitbox_state_machine)
	AddEmptyAnimations("COMBOBREAK", state_machine, hitbox_state_machine)
	
	
func AddEmptyAnimations(current, state_machine, hitbox_machine):
	if state_machine.has_node(current):
		var node = state_machine.get_node(current)
		var hitbox_node = hitbox_machine.get_node(current)
		for i in node.get_blend_point_count():
			%AddHitboxFrame.NewAnimation(false, GetSingleName(node.get_blend_point_node(i).animation), node.get_blend_point_node(i).animation)

func GetSingleName(complexname):
	var new_name : String
	new_name = complexname
	
	new_name = new_name.replace("sprites/", "")
	return new_name

func ChangeAnim(newname, pos):
	var current = %Load.current
	%LOG.text = "Changing anim : " + str(newname) + " :  position : " + str(pos)
	var state_machine = %Load.AttackHitboxTree.tree_root
	if state_machine.has_node(current):
		var node = state_machine.get_node(current)
		for i in node.get_blend_point_count():
			if node.get_blend_point_position(i) == pos:
				node.get_blend_point_node(i).animation = newname
				return
		%LOG.text = "Couldnt find the same position or name"
	else:
		%LOG.text = "NODE ANIM NOT FOUND"

func AddAnim(newname, pos):
	var current = %Load.current
	%LOG.text = "Adding anim : " + str(newname) + " :  position : " + str(pos)
	var state_machine = %Load.AttackHitboxTree.tree_root
	if state_machine.has_node(current):
		var node = state_machine.get_node(current)
		for i in node.get_blend_point_count():
			if node.get_blend_point_position(i) == pos:
				%LOG.text = "Same Position exist : " + str(pos)
				return
		
		var anim_node = AnimationNodeAnimation.new()
		anim_node.animation = newname
		node.add_blend_point(anim_node, pos)
	else:
		%LOG.text = "NODE ANIM NOT FOUND"

func DeleteAnim(newname, pos):
	var current = %Load.current
	%LOG.text = "Deleting anim : " + str(newname) + " :  position : " + str(pos) 
	var state_machine = %Load.AttackHitboxTree.tree_root
	if state_machine.has_node(current):
		var node = state_machine.get_node(current)
		for i in node.get_blend_point_count():
			if node.get_blend_point_position(i) == pos:
				node.remove_blend_point(i)
				return
		%LOG.text = "Couldnt find the same position or name"
	else:
		%LOG.text = "NODE ANIM NOT FOUND"
