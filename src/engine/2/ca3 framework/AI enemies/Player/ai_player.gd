extends CharacterBody2D

var Sprites
@export var IsAI : bool
var Anim

func _ready():
	var Character = FilePaths.Avatars[FilePaths.Characters_selected.get("default", 0)]
	var heroe_folder = FilePaths.Characters_list[FilePaths.Characters_selected.get("default", 0)][1]
	var heroe_scene_path = FilePaths.root_folder + "/objects/characters/" + heroe_folder + Character["sprites scene"]
	
	var tmp0 = load(heroe_scene_path)
	var tmp = tmp0.instantiate()
	tmp.name = "Sprites"
	add_child(tmp)
	Sprites = tmp
	
	Anim = Sprites.get_node("Anim")
	$AIAnimations.Anim = Anim


func GetDistance():
	return $AIINPUT/ConditionsCheck.distance

func AddChaseScore(score, closest):
	$AIINPUT/MinMax.team_chase_bonus += score
	
	if closest:
		$AIINPUT/MinMax.team_chase_bonus += score * 2
		SetDistanceTier(0)
	if $AIINPUT/MinMax.team_chase_bonus > 1000:
		$AIINPUT/MinMax.team_chase_bonus = 1000

func ResetChaseScore():
	$AIINPUT/MinMax.team_chase_bonus = 0

func SetDistanceTier(tier):
	$AIINPUT/DecisionOutput.tier = tier

func ResetClosest():
	ResetChaseScore()
	SetDistanceTier(4)
	
func SetPlayerOffset(new_offset):
	$AIINPUT/MinMax.playeroffset = new_offset

func HIT():
	print("HIT")
	$AITransitions.ChangeState("HURT")


func EndAnim():
	$AITransitions.EndAnimations()

func EndAIAnim():
	%AITransitions.EndAnimations()
