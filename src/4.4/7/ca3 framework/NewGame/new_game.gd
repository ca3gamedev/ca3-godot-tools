extends Node2D


@export var current : int
@export var target : Vector2
@export var subtarget : Vector2
@export var menue : int
@export var submenue : int
@export var file_exist : Array[bool]
@export var unable_color : Color
@export var Variables : Node

@export var y_final_offset : int

func _ready():
	START()
	Frame.LOG(Log.Loading_screen, 5.0, true)
	
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
	subtarget = $SecondMenue.get_node(str(submenue)).global_position

func _process(delta):
	
	if Input.is_action_just_released("UP"):
		if menue == 0:
			if current > 0:
				current -= 1
		else:
			if submenue > 0:
				submenue -= 1
		UpdateCursor()
	
	if Input.is_action_just_released("DOWN"):
		if menue == 0:
			if current < 3:
				current += 1
		else:
			if file_exist[current] and submenue < 1:
				submenue += 1
		UpdateCursor()

	if Input.is_action_just_released("A"):
		if menue == 1:
			if submenue == 0:
				Variables.SaveEmpty(current)
				Variables.LoadSave(current)
				Transitions.Next = SceneDirectory.GetScreen("Overworld")
				self.hide()
				Transitions.Start()
			if submenue == 1:
				Variables.LoadSave(current)
				Transitions.Next = SceneDirectory.GetScreen("Overworld")
				self.hide()
				Transitions.Start()
			if submenue == 2:
				Variables.Save(current)
				self.hide()
		if menue == 0:
			menue += 1
			submenue = 0
			if not file_exist[current]:
				$SecondMenue.get_node(str(1)).get_node("label").set("theme_override_colors/font_color", unable_color)
			else:
				$SecondMenue.get_node(str(1)).get_node("label").set("theme_override_colors/font_color", Color.WHITE)
			$SecondMenue.global_position.y = target.y - 50
			$SecondMenue/RectangleSimple.global_position.y = target.y
			if current == 3 and menue == 1:
				$SecondMenue.global_position.y = target.y - 50 - y_final_offset
				$SecondMenue/RectangleSimple.global_position.y = target.y - y_final_offset
			UpdateCursor()
			$SecondMenue.show()

	if Input.is_action_just_released("B") and menue > 0:
		menue -= 1
		submenue = 0
		UpdateCursor()
		
		$SecondMenue.hide()
	
	
	$RectangleSimple.global_position.y = lerp($RectangleSimple.global_position.y, target.y, delta * 4)
	$SecondMenue/RectangleSimple.global_position.y = lerp($SecondMenue/RectangleSimple.global_position.y, subtarget.y, delta * 4)


func _on_tutorial_pressed():
	Variables.ChangeScene("Tutorial")


func _on_return_pressed():
	Variables.ChangeScene("Title")
