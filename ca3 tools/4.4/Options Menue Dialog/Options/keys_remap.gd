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
	%LOG.text = action + " : " + OS.get_keycode_string(event.get_keycode_with_modifiers())

func ChangeGameActions():
	ChangeKey("UP", Key2input(Root.game_options.up))
	ChangeKey("DOWN", Key2input(Root.game_options.down))
	ChangeKey("LEFT", Key2input(Root.game_options.left))
	ChangeKey("RIGHT", Key2input(Root.game_options.right))
	ChangeKey("A", Key2input(Root.game_options.A))
	ChangeKey("B", Key2input(Root.game_options.B))
	ChangeKey("C", Key2input(Root.game_options.C))
	ChangeKey("D", Key2input(Root.game_options.D))

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
	%LOG.text = "Press a key..."


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
	
	Root.game_options.up = GetEvent("UP")
	Root.game_options.down = GetEvent("DOWN")
	Root.game_options.left = GetEvent("LEFT")
	Root.game_options.right = GetEvent("RIGHT")
	Root.game_options.A = GetEvent("A")
	Root.game_options.B = GetEvent("B")
	Root.game_options.C = GetEvent("C")
	Root.game_options.D = GetEvent("D")

func _on_rebind_timeout():
	UpdateKeysLabels()
	SetKeyData()
	waiting_for_input = false
	%LOG.text = "Key Remaped!"


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
