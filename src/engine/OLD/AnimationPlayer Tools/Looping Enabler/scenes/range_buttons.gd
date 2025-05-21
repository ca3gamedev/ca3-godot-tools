extends Node

var anim_id = 0
var single_id = 0
var batch_begin = 0
var batch_end = 0
var single_selected = 0
var looptype = 0


func _on_anim_list_item_selected(index):
	anim_id = index
	Update()
	


func _on_loop_list_item_selected(index):
	single_id = index
	Update()


func _on_set_range_begin_pressed():
	batch_begin = anim_id
	
	if %AnimList.item_count < 1:
		%Log.text = "THERE'S NOT ANIMATIONS FOR BEGIN SET"
	else:
		Update()


func _on_set_range_end_pressed():
	batch_end = anim_id
	if %AnimList.item_count < 1:
		%Log.text = "THERE'S NOT ANIMATIONS FOR END SET"
	else:
		Update()


func _on_set_single_anim_pressed():
	single_selected = single_id
	if %AnimList.item_count < 1:
		%Log.text = "THERE'S NOT ANIMATIONS FOR SINGLE SET"
	else:
		Update()

func Update():
	ClearColors()
	%AnimList.set_item_custom_bg_color(anim_id, Color.GRAY)
	%LoopList.set_item_custom_bg_color(single_id, Color.GRAY)
	%AnimList.set_item_custom_bg_color(batch_begin, Color.BLUE)
	%AnimList.set_item_custom_bg_color(batch_end, Color.RED)
	%LoopList.set_item_custom_bg_color(single_selected, Color.YELLOW)
	


func ClearColors():
	for i in %AnimList.item_count:
		%AnimList.set_item_custom_bg_color(i, Color.BLACK)
		%LoopList.set_item_custom_bg_color(i, Color.BLACK)


func _on_loop_types_item_selected(index):
	looptype = index


func _on_batch_pressed():
	if %AnimList.item_count < 1:
		%Log.text = "THERE'S NOT ANIMATIONS TO BATCH"
	else:
		%AnimationPlayer.BatchAnims(batch_begin, batch_end, looptype)
		%UpdateLoopList.Update()
		Update()


func _on_batch_single_pressed():
	if %AnimList.item_count < 1:
		%Log.text = "THERE'S NOT ANIMATIONS TO SINGLE BATCH"
	else:
		%AnimationPlayer.SingleBatch(single_selected, looptype)
		%UpdateLoopList.Update()
		Update()
	
