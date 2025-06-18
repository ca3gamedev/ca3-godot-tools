extends Node2D

func _ready():
	HIDE()

func SHOW():
	$CanvasLayer/PAUSELOG.show()

func HIDE():
	$CanvasLayer/PAUSELOG.hide()
