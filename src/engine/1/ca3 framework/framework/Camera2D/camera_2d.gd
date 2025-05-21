extends Camera2D

@export var ShakeStrenght : float = 0.0
@export var speed : float = 10.0

func _ready():
	VariableNodes.MyCamera2D = self

func Shake(hitstun, time):
	ShakeStrenght = hitstun
	speed = time
	
func GetOffSet():
	var x = randf_range(-ShakeStrenght, ShakeStrenght)
	var y = randf_range(-ShakeStrenght, ShakeStrenght)
	return Vector2(x, y)

func _process(delta):
	
	self.global_position = self.global_position.slerp(VariableNodes.Player1.global_position, delta * 5)
	
	if ShakeStrenght != 0.0:
		ShakeStrenght = lerpf(ShakeStrenght, 0.0, delta * speed)
		self.offset = GetOffSet()
