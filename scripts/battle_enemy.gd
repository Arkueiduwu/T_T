extends Node2D
var HP: float = 10
var STRENGTH: float = 10
var AP: int = 3
var maxAP: int = 3
var selectedCommand: int = 0

func _physics_process(delta: float) -> void:
	if HP <= 0:
		die()
	if Input.is_action_just_pressed("debug4"):
		AP -= 1
		print(AP)
	selectedCommand = randi_range(1,2)
	
	if selectedCommand == 1:
		attack()

func die():
	queue_free()

func attack():
	AP -= 1
