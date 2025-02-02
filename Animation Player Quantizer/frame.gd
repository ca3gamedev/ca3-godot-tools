extends TextureButton

var id = 0

func _on_pressed():
	$"../".ChangeColor(id)

func ChangeColor(color):
	$Frame.modulate = color
