extends Node

var MyAnim

func LOADANIMATIONS():
	var animations = MyAnim.get_animation_list()
	%AnimList.clear()
	for i in animations:
		%AnimList.add_item(i)
		
	$"../UpdateLoopList".Update()
	$"../../RangeButtons".Update()

func BatchAnims(begin, end, id):
	var index = 0
	for i in MyAnim.get_animation_list():
		if index >= begin and index <= end:
			MyAnim.get_animation(i).set_loop_mode(id)
		index += 1

func SingleBatch(id, value):
	var list = MyAnim.get_animation_list()
	MyAnim.get_animation(list[id]).set_loop_mode(value)
