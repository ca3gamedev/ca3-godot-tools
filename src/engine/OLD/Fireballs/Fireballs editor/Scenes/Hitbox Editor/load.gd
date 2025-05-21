extends Node

#THESE ARE THE ONES USED TO LOAD THE ANIMATIONS FROM THE PLAYER SCENE
#THIS PLAYER ANIM TREE ARE THE SPRITES
@export var PlayerAnimTree : AnimationTree
@export var AttackHitboxTree : AnimationTree

@export var current : String = ""
@export var current_index : int = 0

func _ready():
	current = "MOVE"
	LOADNODE()


func LOADNODE():
	var state_machine = PlayerAnimTree.tree_root
	
	if state_machine.has_node(current):
		var node = state_machine.get_node(current)
		
		%CurrentNode.clear()
		
		for i in node.get_blend_point_count():
			%CurrentNode.add_item(node.get_blend_point_node(i).animation)
			
		%CurrentNode.set_item_custom_bg_color(current_index, Color.BLUE)
			
	else:
		%LOG.text = "SUB NODE NOT FOUND"
		

func LOADNODEATTACKBOX():
	var state_machine = AttackHitboxTree.tree_root
	
	if state_machine.has_node(current):
		var node = state_machine.get_node(current)
		
		%HitboxAnimations.clear()
		
		for i in node.get_blend_point_count():
			%HitboxAnimations.add_item(node.get_blend_point_node(i).animation)
	else:
		%LOG.text = "SUB NODE NOT FOUND"
		


func _on_current_node_item_selected(index):
	current_index = index


func _on_typeof_move_item_selected(index):
	current = %TypeofMove.get_item_text(index)
	LOADNODE()
	
