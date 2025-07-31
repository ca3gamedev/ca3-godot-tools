extends Node

@export var dialog_scene : PackedScene
@export var y_off : int
@export var id : int
@export var max : int
@export var ani_frames : int

var modulo_frames = 1
var frame_id = 0

func _ready():
	max = len(%Dialog.dialog)
	modulo_frames = max / ani_frames
	%Ani.frame = 0
	for i in max:
		var tmp = dialog_scene.instantiate()
		tmp.position.y = i * y_off
		tmp.SetDialog(%Dialog.dialog[i])
		tmp.name = str(i)
		$"../SubViewportContainer/SubViewport/DialogsBalloons".add_child(tmp)

func _process(delta):
	
	if Input.is_action_just_released("A") and id < max:
		id += 1
		frame_id += 1
		if frame_id >= modulo_frames:
			frame_id = 0
			var frame = %Ani.frame
			frame += 1
			%Ani.frame = frame
		if id < max:
			$"../SubViewportContainer/SubViewport/DialogsBalloons".target = $"../SubViewportContainer/SubViewport/DialogsBalloons".get_node(str(id)).position.y
		else:
			VariableNodes.Countries_finished[VariableNodes.Countries_selected] = true
			VariableNodes.battle_won = true
			Transitions.Next = SceneDirectory.GetScreen("Overworld")
			Transitions.Start()
