extends Node

@export var Level : int

func GetScreen(id):
	match(id):
		"Title" : return $Screens.Title
		"Tutorial" : return $Screens.Tutorial
		"Game Over" : return $Screens.GameOver
		"World Map" : return $Level1.world_map
		"Overworld" : return $Screens.OverWorld
		"Intro" : return $Screens.Intro
		"Ending" : return $Screens.Ending
		"Congratulations" : return $Screens.Congratulations
		"Gallery" : return $Screens.gallery

func GetNextLevel(id):
	
	return GetLevel1(id)

func GetLevel1(id):
	match(id):
		"Home" : return $Level1.Home
		"Level 01" : return $Level1.Level01
		"Level 02" : return $Level1.Level02
		"Level 03" : return $Level1.Level03
		"Battle" : return $Level1.Battle
		"Victory Points" : return $Level1.VictoryPoints
		"Relationships" : return $Level1.Relationships
		"Tarot" : return $Level1.Tarot
		"Intro" : return $Level1.Intro
		"VN" : return $Level1.VN
		"Roguelike" : return $Level1.Roguelike2D
		"2D turn Fighter" : return $Level1.TurnBasedFighter2D
