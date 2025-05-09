extends Node2D

@onready var participants: Node2D = $participants
var previousScene: String = "res://scenes/Overworld.tscn"
var round: Array = []
var currentIndex: int = 0
var isBattling: bool = true
var enemyCount: int = 0
var noMoreEnemies: bool = false

var currentTurn: Node2D = null

func _ready() -> void:
	round = participants.get_children()
	currentTurn = round[0]
	enemyCount = countEnemies()

func _physics_process(delta: float) -> void:
	if not isBattling:
		exitCombat()
	if currentTurn.AP <= 0:
		passTurn()
		
	if enemyCount == 0:
		noMoreEnemies = true
	
	if noMoreEnemies:
		isBattling = false
		
	

func exitCombat() -> void:
	get_tree().change_scene_to_file(previousScene)

func passTurn() -> void:
	if currentIndex == len(round) - 1:
		currentIndex = 0
	else:
		currentIndex += 1
	currentTurn = round[currentIndex]
	currentTurn.AP = currentTurn.maxAP
	enemyCount = countEnemies()
	

func countEnemies() -> int:
	var count = 0
	for participant in round:
		if participant.is_in_group("enemy"):
			count += 1
	return count

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug2"):
		noMoreEnemies = true


func _on_battle_enemy_tree_exited() -> void:
	round.pop_at(currentIndex)
	enemyCount -= 1
	
