extends Node

var keytimer = 3.0
var buttontimer = 3.0

@onready var buffer = get_tree().get_root().get_node("INPUT/Buffer")

func _ready():
	Update()

func Update():
	
	if buffer == null:
		return
	
	%BufferWindowLog.text = str(buffer.KeyBufferResetTimerMax)
	%BufferButtonWindowLog.text = str(buffer.ButtonBufferReserTimerMax)

func _on_set_buffer_time_pressed():
	buffer.KeyBufferResetTimerMax = keytimer
	Update()


func _on_buffer_key_text_changed(new_text):
	if new_text.is_valid_float():
		keytimer = new_text
	else:
		%BufferKey.text = str(keytimer)


func _on_buffer_button_text_changed(new_text):
	if new_text.is_valid_float():
		buttontimer = new_text
	else:
		%BufferButton.text = str(buttontimer)


func _on_set_buffer_button_time_pressed():
	buffer.ButtonBufferReserTimerMax = buttontimer
	Update()
