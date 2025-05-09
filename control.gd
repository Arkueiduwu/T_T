extends Control
var overworldScene: String = "res://scenes/Overworld.tscn"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(overworldScene)
	
