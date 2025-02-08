extends Node

var dir = []
var button = []
var mydelta = 0

@export var KeyBufferResetTimerMax : float = 1.0
@export var ButtonBufferReserTimerMax : float = 1.0

var KeyBufferResetTimer : float = 0.0
var ButtonBufferResetTimer : float = 0.0

func _process(delta):
	
	mydelta = delta
	
	if KeyBufferResetTimer > KeyBufferResetTimerMax:
		dir.clear()
		KeyBufferResetTimer = 0.0
	
	if ButtonBufferResetTimer > ButtonBufferReserTimerMax:
		button.clear()
		button.append("none")
		ButtonBufferResetTimer = 0.0

func AddDir(new_dir):
	if len(dir) < 1:
		dir.append(new_dir)
		KeyBufferResetTimer = 0.0
	else:
		if dir[0] != new_dir:
			dir.insert(0, new_dir)
			KeyBufferResetTimer = 0.0
		else:
			KeyBufferResetTimer += mydelta
		if len(dir) > 10:
			dir.remove_at(9)

func AddButton(new_button):
	
	if new_button == "none":
		ButtonBufferResetTimer += mydelta
	
	if len(button) < 1 and new_button != "none":
		button.append(new_button)
		ButtonBufferResetTimer = 0.0
	elif len(button) > 0:
		if new_button != "none":
			button.insert(0, new_button)
			ButtonBufferResetTimer = 0.0
		if len(button) > 10 :
			button.remove_at(10)
 
func Get0Dir():
	var tmp = Vector2i.ZERO
	if dir.size() > 0:
		tmp = dir[0]
	return tmp

func Get0Button():
	var tmp = "none"
	if button.size() > 0:
		tmp = button[0]
	return tmp

func GetJump():
	if dir.size() > 1:
		if dir[1].y == -2:
			return true
	return false

func IsUp():
	if dir.size() > 0:
		if dir[1].y == -1:
			return true
	return false

func IsDown():
	if dir.size() > 0:
		if dir[1].y == 1:
			return true
	return false
