extends Node2D

@export var GameLoaded : bool

@export var current : int
@export var target : Vector2
@export var subtarget : Vector2
@export var menue : int
@export var submenue : int
@export var file_exist : Array[bool]
@export var unable_color : Color
@export var Variables : Node

func _ready():
	START()
	
func START():
	UpdateCursor()
	$SecondMenue.hide()
	
	for i in 4:
		file_exist.append(Variables.CheckSaveExist(i))
	
	for i in 4:
		if not file_exist[i]:
			$Options.get_node(str(i)).get_node("label").set("theme_override_colors/font_color", unable_color)
		else:
			$Options.get_node(str(i)).get_node("label").set("theme_override_colors/font_color", Color.WHITE)


func UpdateCursor():
	target = $Options.get_node(str(current)).global_position
	subtarget = $SecondMenue.get_node(str(0)).global_position

func _process(delta):
	
	if GameLoaded:
		if Input.is_action_just_released("D"):
			self.hide()
			GameLoaded = false
			$"../".is_store = false
			$"../".UNPAUSE()
	
	if Input.is_action_just_released("UP"):
		if current > 0:
			current -= 1
		UpdateCursor()
	
	if Input.is_action_just_released("DOWN"):
		if current < 3:
			current += 1
		UpdateCursor()

	if Input.is_action_just_released("A"):
		if menue == 1:
			Variables.Save(current)
			self.hide()
			GameLoaded = false
			$"../".is_store = false
			$"../".UNPAUSE()
		if menue == 0:
			menue += 1
			$SecondMenue.global_position.y = target.y - 50
			$SecondMenue/RectangleSimple.global_position.y = target.y
			UpdateCursor()
			$SecondMenue.show()

	if Input.is_action_just_released("B") and menue > 0:
		menue -= 1
		UpdateCursor()
		
		$SecondMenue.hide()
	
	
	$RectangleSimple.global_position.y = lerp($RectangleSimple.global_position.y, target.y, delta * 4)
	$SecondMenue/RectangleSimple.global_position.y = lerp($SecondMenue/RectangleSimple.global_position.y, subtarget.y, delta * 4)


func _on_tutorial_pressed():
	Variables.ChangeScene("Tutorial")


func _on_return_pressed():
	Variables.ChangeScene("Title")
