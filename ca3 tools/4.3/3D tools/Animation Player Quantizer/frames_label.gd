extends HBoxContainer

var current_frame = 0

func _ready():
	await  get_tree().process_frame
	ChangeColor(0)

func ChangeColor(id):
	current_frame = id
	%CurrentFrameLog.text = str(current_frame)
	
	for i in get_children():
		i.ChangeColor(Color.WHITE)
		if i.id == current_frame:
			i.ChangeColor(Color.RED)
