extends Node

var node_name_index = 0


func _on_open_pressed():
	%OpenScene.show()


func _on_open_scene_file_selected(path):
	
	var file = ResourceLoader.load(path)
	AddScene(file)

func AddScene(scene):
	
	for i in %Root.get_children():
		i.queue_free()
	
	var tmp = scene.instantiate()
	%Root.add_child(tmp)
	
	var empty = true
	var myname = "none"
	
	%Nodes.clear()
	for i in %Root.get_children():
		%Nodes.add_item(i.name)
		%Nodes.add_item("**********")
		for a in i.get_children():
			%Nodes.add_item(a.name)
			if a.get_class() == "AnimationPlayer":
				%Nodes.set_item_custom_bg_color(%Nodes.item_count-1, Color.RED)
				empty = false
				myname = a.name
	if empty:
		%Log.text = "SCENE LACKS AN ANIMATIONPLAYER NODE"
	else:
		%Log.text = "I FOUND " + myname


func _on_open_animation_player_pressed():
	
	var file = %Root.get_child_count()
	var filefound = false
	
	var nodename = "Root"
	if file > 0:
		nodename = %Nodes.get_item_text(node_name_index)
	
	if file == 0:
		%Log.text = "THERE'S NO SCENE LOADED"
	elif nodename == %Nodes.get_item_text(0):
		%Log.text = "THIS IS THE SCENE ROOT NODE"
	elif nodename == %Nodes.get_item_text(1):
		%Log.text = "THIS IS A SEPARATOR"
	else:
		if nodename == "":
			%Log.text = "NODE NAME EMPTY"
		else:
			var children = %Root.get_children()
			var animplayer = children[0].get_node(nodename)
			
			if not children[0].has_node(nodename):
				%Log.text = "CANT FIND THAT NODE, RESULT IT'S NULL"
			else:
				if animplayer.get_class() == "AnimationPlayer":
					%Log.text = animplayer.name + " LOADED"
					$AnimationPlayer.MyAnim = animplayer
					filefound = true
				else:
					%Log.text = "COULDN'T FIND AN ANIMATION PLAYER WITH THAT NAME"
	
	if filefound:
		%Log.text = "LOADING ANIMATIONS"
		$AnimationPlayer.LOADANIMATIONS()


func _on_nodes_item_selected(index):
	node_name_index = index
