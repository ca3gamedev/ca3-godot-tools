extends Node

@export var fireball_scene : PackedScene

func Update():
	%FireballSpawnTimer.start(randf_range(0.2, 2))


func _on_fireball_spawn_timer_timeout():
	var tmp = fireball_scene.instantiate()
	tmp.angle = (VariableNodes.Player1.global_position - $"../../".global_position).normalized()
	tmp.global_position = $"../../".global_position
	VariableNodes.EnemyBulletManager.add_child(tmp)
