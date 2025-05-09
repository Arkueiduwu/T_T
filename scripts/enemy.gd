extends CharacterBody2D
@onready var spriteSheet: AnimatedSprite2D = $AnimatedSprite2D
@onready var battleScenePath : String = "res://scenes/battle.tscn"


func _ready() -> void:
	spriteSheet.play("default")

func enterCombat():
	get_tree().change_scene_to_file(battleScenePath)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area)
	if area.is_in_group("player"):
		enterCombat()
