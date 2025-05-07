extends Node2D
@onready var combatScene: Control = $Combat

func _physics_process(delta: float) -> void:
	pass
	
func startCombat():
	print(combatScene.is_visible_in_tree())
	
