extends Node

# Dictionary mapping generic state names to actual child node names
var states: Dictionary = {
	"idle": "IDLE",
	"walk": "WALK",
	"jump": "JUMP",
	"crouch": "CROUCH",
	"hop": "HOP",
	"hurt": "HURT",
	"punch": "PUNCH"
}
