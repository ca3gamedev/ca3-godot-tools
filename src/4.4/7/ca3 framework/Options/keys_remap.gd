extends Node

@onready var Root = $".."
var waiting_for_input = false
var current_action = ""


func _unhandled_input(event):
	if waiting_for_input and event is InputEventKey and event.pressed:
		ChangeKey(current_action, event)
		

func ChangeKey(action, event):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	var text = action + " : " + OS.get_keycode_string(event.get_keycode_with_modifiers())
	Frame.LOG([[text], false], 4.0, true)

func ChangeGameActions():
	ChangeKey("UP", Key2input(Config.game_options.up))
	ChangeKey("DOWN", Key2input(Config.game_options.down))
	ChangeKey("LEFT", Key2input(Config.game_options.left))
	ChangeKey("RIGHT", Key2input(Config.game_options.right))
	ChangeKey("A", Key2input(Config.game_options.A))
	ChangeKey("B", Key2input(Config.game_options.B))
	ChangeKey("C", Key2input(Config.game_options.C))
	ChangeKey("D", Key2input(Config.game_options.D))

func Key2input(keycode: int) -> InputEventKey:
	var event := InputEventKey.new()
	event.keycode = keycode
	event.pressed = true
	event.echo = false
	return event


func GetKeycode(action_name: String) -> String:
	var events = InputMap.action_get_events(action_name)
	return OS.get_keycode_string(events[0].keycode)

func GetEvent(action):
	var events = InputMap.action_get_events(action)
	return events[0].keycode

func RemapKey():
	waiting_for_input = true
	Frame.LOG([["Press a key...."], false], 4.0, true)


func _on_up_pressed():
	if not waiting_for_input:
		current_action = "UP"
		RemapKey()
		%Rebind.start(1)


func UpdateKeysLabels():
	%Uplog.text = GetKeycode("UP")
	%Downlog.text = GetKeycode("DOWN")
	%Leftlog.text = GetKeycode("LEFT")
	%Rightlog.text = GetKeycode("RIGHT")
	%Alog.text = GetKeycode("A")
	%Blog.text = GetKeycode("B")
	%Clog.text = GetKeycode("C")
	%Dlog.text = GetKeycode("D")

func SetKeyData():
	
	Config.game_options.up = GetEvent("UP")
	Config.game_options.down = GetEvent("DOWN")
	Config.game_options.left = GetEvent("LEFT")
	Config.game_options.right = GetEvent("RIGHT")
	Config.game_options.A = GetEvent("A")
	Config.game_options.B = GetEvent("B")
	Config.game_options.C = GetEvent("C")
	Config.game_options.D = GetEvent("D")

func _on_rebind_timeout():
	UpdateKeysLabels()
	SetKeyData()
	waiting_for_input = false
	Frame.LOG([["Key Remaped!."], false], 4.0, true)


func _on_down_pressed():
	if not waiting_for_input:
		current_action = "DOWN"
		RemapKey()
		%Rebind.start(1)


func _on_right_pressed():
	if not waiting_for_input:
		current_action = "RIGHT"
		RemapKey()
		%Rebind.start(1)


func _on_left_pressed():
	if not waiting_for_input:
		current_action = "LEFT"
		RemapKey()
		%Rebind.start(1)


func _on_a_pressed():
	if not waiting_for_input:
		current_action = "A"
		RemapKey()
		%Rebind.start(1)


func _on_b_pressed():
	if not waiting_for_input:
		current_action = "B"
		RemapKey()
		%Rebind.start(1)


func _on_c_pressed():
	if not waiting_for_input:
		current_action = "C"
		RemapKey()
		%Rebind.start(1)


func _on_d_pressed():
	if not waiting_for_input:
		current_action = "D"
		RemapKey()
		%Rebind.start(1)
