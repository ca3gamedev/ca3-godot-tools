extends Node

@export var PlayerAnimTree : AnimationTree
@export var PlayerAnimPlayer : AnimationPlayer

func _on_load_attack_pressed():
	
	%LoadParams.current = "ATTACK"
	%LoadParams.LOADNODE()


func _on_typeof_move_item_selected(index):
	%LoadParams.current = %TypeofMove.get_item_text(index)
	%LoadParams.LOADNODE()


func _on_ready():
	
	var tree = PlayerAnimTree.tree_root
	var node = tree.get_node("MOVE")
	
	var animations = PlayerAnimPlayer.get_animation_list()
	%AnimationNames.clear()
	for i in animations:
		%AnimationNames.add_item(i)
	
	await  get_tree().process_frame
	
	%LoadParams.current = %TypeofMove.get_item_text(0)
	%LoadParams.LOADNODE()
