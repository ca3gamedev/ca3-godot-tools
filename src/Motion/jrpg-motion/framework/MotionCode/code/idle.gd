extends Node

func Physics(delta):
	if $"../".Transition.GetState() == "JRPG DASH":
		$"../".Transition.ChangeMotion("DASH")
	if $"../".Transition.IsWalk():
		$"../".Transition.ChangeMotion("WALK")
