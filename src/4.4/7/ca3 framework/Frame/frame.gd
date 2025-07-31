extends Node2D

var finished = false
var current_log = ""
var id = 0
var loop = false
var time = 2

func _ready():
	LOG(Log.Title, 5.0, true)


func ShowCRT():
	%CRT.show()

func HideCRT():
	%CRT.hide()

func _process(delta):
	if not finished:
		%DownLOG.visible_ratio = lerp(%DownLOG.visible_ratio, 1.0, delta * 2)
		if %DownLOG.visible_ratio == 1.0:
			finished = true

func LOG(new_text, new_time, new_loop):
	time = new_time
	loop = new_loop
	current_log = new_text
	id = 0
	finished = false
	%DownLOG.text = current_log[0][id]
	%DownLOG.visible_ratio = 0
	$Timer.start(time)

func LOGSTART():
	$Timer.start(time)
	finished = false
	%DownLOG.text = current_log[0][id]
	%DownLOG.visible_ratio = 0

func _on_timer_timeout():
	if current_log[1] and not Config.game_options.TutorialTips:
		$Timer.stop()
		%DownLOG.text = ""
		return
	
	id += 1
	if id >= current_log[0].size():
		id = 0
		if not loop:
			$Timer.stop()
			%DownLOG.text = ""
			return
	finished = false
	%DownLOG.text = current_log[0][id]
	%DownLOG.visible_ratio = 0

func StopLOG():
	$Timer.stop()
	%DownLOG.text = ""
