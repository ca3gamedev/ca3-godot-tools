extends Node

func MinMax():
	
	if $"../GetDistance".current_distance > $"../GetDistance".distance_type.melee:
		if $"../Mood".current_mood == $"../Mood".mood.agressive:
			$"../Target".goal = $"../Target".goal_type.chase
		if randi()%10 > 8:
			var jump = randi_range(1, 10)
			if jump > 7:
				if randi()%10 > 6:
					$"../Target".goal = $"../Target".goal_type.jump_b
				else:
					$"../Target".goal = $"../Target".goal_type.jump_f
			else:
				$"../Target".goal = $"../Target".goal_type.jump_f
	
	if $"../GetDistance".current_distance < $"../GetDistance".distance_type.long:
		if $"../Mood".current_mood == $"../Mood".mood.keepaway:
			$"../Target".goal = $"../Target".goal_type.keepaway
