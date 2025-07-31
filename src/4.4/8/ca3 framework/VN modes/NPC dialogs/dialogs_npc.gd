extends Node2D

@export var NPC1 : Node
@export var max_id : int
@export var id : int

@export var idle : bool

func _ready():
	HIDE()

func StartDialog():
	$ColorRect.show()
	$Label.show()
	idle = false

func HIDE():
	$ColorRect.hide()
	$Label.hide()


func _process(delta):
	
	if not idle :
		if Input.is_action_just_released("A"):
			id += 1
			$Label.text = NPC1.dialog[randi_range(0, len(NPC1.dialog)-1)]
		
		if id > max_id:
			HIDE()
			id = 0
			$"../".UNPAUSE()
			idle = true
