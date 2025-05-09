extends Node2D
var battle: bool = false
var previousScene: String = "res://scenes/Overworld.tscn"
var roundOrder = {}


func exitCombat():
	get_tree().change_scene_to_file(previousScene)
	
func _physics_process(delta: float) -> void:
	if battle:
		print(battle)
	
func _on_attack_pressed() -> void:
	exitCombat()
