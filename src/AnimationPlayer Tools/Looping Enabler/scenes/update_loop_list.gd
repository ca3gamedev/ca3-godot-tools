extends Node

func Update():

	%LoopList.clear()
	for id in %AnimationPlayer.MyAnim.get_animation_list():
		var loop = %AnimationPlayer.MyAnim.get_animation(id).get_loop_mode()
		%LoopList.add_item(str(loop))
