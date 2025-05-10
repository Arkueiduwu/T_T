extends Node2D
var stats: Dictionary = {
	"HP": {"value": 10.0, "min": 0.0, "max": 10.0, "type": "float"},
	"AP": {"value": 2, "min": 0, "max": 3, "type": "int"},
	"AD": {"value": 10.0, "min": 0.0, "max": INF, "type": "float"}
}
var selectedCommand: int = 0

func _physics_process(delta: float) -> void:
	if stats["HP"]["value"] <= 0:
		die()
	if Input.is_action_just_pressed("debug4"):
		stats["AP"]["value"] -= 1
		print(stats["AP"]["value"])
	selectedCommand = randi_range(1,2)
	
	if selectedCommand == 1:
		attack()

func die():
	queue_free()

func attack():
	stats["AP"]["value"] -= 1
