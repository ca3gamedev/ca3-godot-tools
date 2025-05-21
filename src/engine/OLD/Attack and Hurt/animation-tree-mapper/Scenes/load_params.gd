extends Node

@export var current : String = ""

func _ready():
	await get_tree().process_frame
	UpdateParameters()


func _on_load_parameters_pressed():
	current = %TypeofMove.get_item_text(%TypeofMove.get_selected_id())
	LOADNODE()


func LOADNODE():
	var state_machine = %Load.PlayerAnimTree.tree_root
	
	if state_machine.has_node(current):
		var node = state_machine.get_node(current)
		%CurrentNodeLabel.text = current + " SELECTED"
		
		%CurrentNode.clear()
		
		for i in node.get_blend_point_count():
			%CurrentNode.add_item(str(i) + " : " + node.get_blend_point_node(i).animation + " : " + str(node.get_blend_point_position(i)))
	else:
		%LOG.text = "SUB NODE NOT FOUND"
		
	

func UpdateParameters():
	var state_machine = %Load.PlayerAnimTree.get_property_list()
	
	%parameters.clear()
	for i in state_machine:
		var name = i.name
		if name.contains("parameters/"):
			%parameters.add_item(i["name"])


func _on_node_name_text_changed(new_text):
	if typeof(new_text) == TYPE_STRING:
		current = new_text


func _on_node_name_text_submitted(new_text):
	if typeof(new_text) == TYPE_STRING:
		current = new_text


func _on_current_node_item_selected(index):
	%LOG.text = %CurrentNode.get_item_text(index)


func ChangeAnim(newname, pos):
	
	%LOG.text = "Changing anim : " + str(newname) + " :  position : " + str(pos) 
	var state_machine = %Load.PlayerAnimTree.tree_root
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
	
	%LOG.text = "Adding anim : " + str(newname) + " :  position : " + str(pos) 
	var state_machine = %Load.PlayerAnimTree.tree_root
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
	
	%LOG.text = "Deleting anim : " + str(newname) + " :  position : " + str(pos) 
	var state_machine = %Load.PlayerAnimTree.tree_root
	if state_machine.has_node(current):
		var node = state_machine.get_node(current)
		for i in node.get_blend_point_count():
			if node.get_blend_point_position(i) == pos:
				node.remove_blend_point(i)
				return
		%LOG.text = "Couldnt find the same position or name"
	else:
		%LOG.text = "NODE ANIM NOT FOUND"
