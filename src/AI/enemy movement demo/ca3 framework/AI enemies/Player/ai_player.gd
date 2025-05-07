extends CharacterBody2D


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
	$AITransitions.ChangeState("HURT")
