extends Node2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	Main.autoUnload()
	Main.autoLoad(["default"],[ 
		["overworld", 1], 
		["player", 1, LastValidPosition], 
		["camera", 1, Main.playerLastValidPosition], 
		Main.mainScene])
	print(Main.instancesLoaded)
