extends CharacterBody2D

var Sprites
@export var IsAI : bool
var Anim

@export var HP : int
@export var enemy_damage : int

func _ready():
	Sprites = $Sprites
	
	Anim = Sprites.get_node("Anim")
	$AIAnimations.Anim = Anim
	$GUI/HPBar.max_value = HP
	$GUI/HPBar.value = HP


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
	HP -= VariableNodes.player_damage
	$GUI/HPBar.value = HP
	$AITransitions.ChangeState("HURT")


func EndAnim():
	$AITransitions.EndAnimations()

func EndAIAnim():
	%AITransitions.EndAnimations()

func DAMAGE(hit):
	HP -= hit
	$GUI/HPBar.value = HP
	
	if HP < 1:
		self.queue_free()
