extends Node3D

@export var id : int
@export var mesh : MeshInstance3D

func _ready():
	id = randi() % 3
	
	match(id):
		0 : mesh.get_active_material(0).albedo_color = Color.YELLOW
		1 : mesh.get_active_material(0).albedo_color = Color.BLUE
		2 : mesh.get_active_material(0).albedo_color = Color.RED
	
	$LOG.text = "LEE " + str(id)
	
	if randi() % 4 <= 2:
		self.queue_free()


func _on_area_3d_body_entered(body):
	
	if body.is_in_group("PLAYER"):
		RelationshipScores.relationships[id] += 2
		self.queue_free()
