extends Node2D
var hp: float = 10

func _physics_process(delta: float) -> void:
	if hp <= 0:
		die()

func die():
	queue_free()
