extends Node

@export var Root : Node2D
var node_selected : int = 0
var anim_selected : int = 0
var animationplayer
var animatedsprites 

func _on_file_dialog_file_selected(path):
	
	var tmp0 = load(path)
	var tmp = tmp0.instantiate()
	Root.add_child(tmp)
	
	%Childrens.clear()
	
	for i in Root.get_children():
		%Childrens.add_item(i.name)
		%Childrens.add_item("*****")
		for a in i.get_children():
			%Childrens.add_item(i.name+"/"+a.name)


func _on_open_pressed():
	%OpenDIALOG.show()


func _on_load_pressed():
	
	var node_name = %Childrens.get_item_text(node_selected)
	
	if Root.get_child_count() > 0 :
		var node = Root.get_node(node_name)
		if node != null:
			if node.get_class() == "AnimatedSprite2D":
				
				%Data.hitbox_pos = []
				%Data.hitbox_size = []
				%Data.hurtbox_pos = []
				%Data.hurtbox_size = []
				%Data.fireball_pos = []
				
				animatedsprites = node
				%Animations.clear()
				for i in node.sprite_frames.get_animation_names():
					%Animations.add_item(i)
					
					%Data.hitbox_pos.append([i])
					%Data.hitbox_size.append([i])
					%Data.hurtbox_pos.append([i])
					%Data.hurtbox_size.append([i])
					%Data.fireball_pos.append([i])


func _on_childrens_item_selected(index):
	node_selected = index


func _on_animations_item_selected(index):
	anim_selected = index
	
	UpdateListFrames()
	%Mouse.Update()
	

func UpdateListFrames():
	%Frames.clear()
	animatedsprites.animation = %Animations.get_item_text(anim_selected)
	
	for i in animatedsprites.sprite_frames.get_frame_count(%Animations.get_item_text(anim_selected)):
		%Frames.add_item(str(i))
