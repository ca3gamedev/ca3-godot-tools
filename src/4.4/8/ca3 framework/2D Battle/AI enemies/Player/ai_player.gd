extends CharacterBody2D

var Sprites
@export var IsAI : bool
var Anim
@export var IsHadouken : bool
@export var IsHealer : bool

@export var HP : int
@export var enemy_damage : int
@export var enemy_lover : CharacterBody2D
var born_origin
var healing_fireball_delay = true

var target : CharacterBody2D
@export var IsAutobattler : bool
@export var TeamID : int
@export var Center : Marker2D

func _ready():
	
	HP += VariableNodes.Level * 20
	enemy_damage += (VariableNodes.Level / 2) * 3
	
	Sprites = $Sprites
	
	Anim = Sprites.get_node("Anim")
	$AIAnimations.Anim = Anim
	$GUI/HPBar.max_value = HP
	$GUI/HPBar.value = HP
	$AIMotion.speed_walk += (VariableNodes.Level / 3) * 20
	
	born_origin = self.global_position

func _process(delta):
	
	if not is_instance_valid(target):
		target = VariableNodes.Player1
	
	if enemy_lover == null:
		var enemies = get_parent().get_child_count()
		var id = randi_range(0, enemies)
		if id >= get_parent().get_child_count():
			enemy_lover = get_parent().get_child(0)
		else:
			enemy_lover = get_parent().get_child(id)

func GetDistance():
	return $AIINPUT/ConditionsCheck.distance

func AddChaseScore(score, closest):
	$AIINPUT/MinMax.team_chase_bonus += score
	
	if IsHadouken :
		if closest:
			$AIINPUT/MinMax.team_chase_bonus += score * 2
		if $AIINPUT/MinMax.team_chase_bonus > 250:
			$AIINPUT/MinMax.team_chase_bonus = 250
	else:
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
	if HP < 1:
		self.queue_free()
	$GUI/HPBar.value = HP
	$AITransitions.ChangeState("HURT")

func HEAL():
	$GUI/HPBar.value += ((VariableNodes.Level * 5) / 3) + 10
	HP = $GUI/HPBar.value
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


func _on_healing_delay_timeout():
	healing_fireball_delay = true
