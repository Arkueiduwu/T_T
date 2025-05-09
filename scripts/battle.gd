extends Node2D
class_name BattleSystem

# Basic battle variables
@onready var participants: Node2D = $participants
var battle: bool = false
var previous_scene: String = "res://scenes/Overworld.tscn"
var round: Array = []

func _ready() -> void:
	for node in participants.get_children():
		addToTheRound(node)
	print(round)


func _physics_process(delta: float) -> void:
	pass

func exit_combat() -> void:
	get_tree().change_scene_to_file(previous_scene)

func _on_attack_pressed() -> void:
	round[0].hp -= round[1].attack
	print(round[0].hp)
	
func addToTheRound(node: Node2D):
	round.append(node)
	
	
