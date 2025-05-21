extends Node

var button = []
var mydelta = 0
#CHARGE BUFFER ORTHO
var charge = []
#D PAD ORTHO BUFFER
var ortho_dir = []
#D PAD ORTHO WITH DIAGONALS SIGNALS
var dia_dir = []
#D PAD RELEASE SIGNALS
var rel_dir = []
#Last input raw
var raw0 = Vector2i.ZERO
#Last since release press
var last_release_time = 0


@export var KeyBufferResetTimerMax : float = 1.0
@export var ButtonBufferReserTimerMax : float = 1.0
@export var ReleaseKeyTimerMax : float = 0.5
@export var buffersize : int

var KeyBufferResetTimer : float = 0.0
var ButtonBufferResetTimer : float = 0.0
var ReleaseKeyTimer : float = 0.0

func _process(delta):
	
	mydelta = delta
	
	if KeyBufferResetTimer > KeyBufferResetTimerMax:
		Clear()
	else:
		KeyBufferResetTimer += delta
	
	if ButtonBufferResetTimer > ButtonBufferReserTimerMax:
		button.clear()
		button.append("none")
		ButtonBufferResetTimer = 0.0
	
	if ReleaseKeyTimer > ReleaseKeyTimerMax:
		if rel_dir.size() > 0:
			rel_dir.clear()
			rel_dir.append(Vector2i.ZERO)
			ReleaseKeyTimer = 0.0
	else:
		ReleaseKeyTimer += delta
	
	if last_release_time < 5:
		last_release_time += delta

func AddDir(new_dir):
	
	raw0 = new_dir
	
	if len(dia_dir) < 1:
		dia_dir.append(new_dir)
		ortho_dir.append(new_dir)
		charge.append(0.0)
		KeyBufferResetTimer = 0.0
		if len(rel_dir) < 1:
			rel_dir.append(new_dir)
	else:
		if dia_dir[0] != new_dir:
			if new_dir == Vector2i(-1, 0) or new_dir == Vector2i(1, 0) or new_dir == Vector2i(0, 1) or new_dir == Vector2i(0, -1) or new_dir == Vector2i(-1, 1) or new_dir == Vector2i(1, 1) or new_dir == Vector2i(1, -1) or new_dir == Vector2i(-1, -1):
				dia_dir.insert(0, new_dir)
				KeyBufferResetTimer = 0.0
				charge.insert(0, 0.0)
			if new_dir == Vector2i(-1, 0) or new_dir == Vector2i(1, 0) or new_dir == Vector2i(0, 1) or new_dir == Vector2i(0, -1):
				ortho_dir.insert(0, new_dir)
			
			if new_dir.x == -2 or new_dir.x == 2 or new_dir.y == -2 or new_dir.y == 2:
				var tmp = new_dir
				if tmp.x == 2:
					tmp.x = 1
				if tmp.x == -2:
					tmp.x = -1
				if tmp.y == 2:
					tmp.y = 1
				if tmp.y == -2:
					tmp.y = -1
				ReleaseKeyTimer = 0.0
				last_release_time = 0
				rel_dir.insert(0, tmp)
			
		if rel_dir.size() > 9:
			rel_dir.remove_at(9)
		if new_dir == dia_dir[0]:
			charge[0] += mydelta
		if ortho_dir.size() > 9 :
			ortho_dir.remove_at(9)
		if charge.size() > 9 :
			charge.remove_at(9)
		if dia_dir.size() > buffersize:
			dia_dir.remove_at(buffersize-1)

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
		if len(button) > buffersize :
			button.remove_at(buffersize-1)
 
func Get0Dir():
	var tmp = Vector2i.ZERO
	if dia_dir.size() > 0:
		tmp = dia_dir[0]
	return tmp

func Get0Button():
	var tmp = "none"
	if button.size() > 0:
		tmp = button[0]
	return tmp

func GetJump():
	if rel_dir.size() > 1:
		if rel_dir[1].y == -2:
			return true
	return false

func IsUp():
	if ortho_dir.size() > 0:
		if ortho_dir[1].y == -1:
			return true
	return false

func IsDown():
	if ortho_dir.size() > 0:
		if ortho_dir[1].y == 1:
			return true
	return false

func GetDir(index, value):
	if ortho_dir.size() > 0:
		if index > ortho_dir.size()-1:
			return false
		elif ortho_dir[index] == value:
			return true
	return false

func GetRawDir(index):
	if dia_dir.size() > 0:
		if index > dia_dir.size()-1:
			return Vector2i(0, 0)
		return dia_dir[index]
	return Vector2i(0, 0)

func Clear():
	rel_dir.clear()
	charge.clear()
	ortho_dir.clear()
	dia_dir.clear()
	KeyBufferResetTimer = 0.0

func AddDummyRelease():
	rel_dir.append(Vector2i.ZERO)
