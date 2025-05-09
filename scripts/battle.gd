extends Node2D

### References ###
@onready var participants: Node2D = $participants

### Battle State ###
var previousScene: String = "res://scenes/Overworld.tscn"
var turnOrder: Array = []
var currentTurnIndex: int = 0
var isBattling: bool = true
var remainingEnemies: int = 0
var battleVictory: bool = false
var currentActor: Node2D = null

func _ready() -> void:
	initializeBattle()

func _physics_process(delta: float) -> void:
	if not isBattling:
		exitCombat()
		return
	
	# Skip processing if current actor is invalid
	if not is_instance_valid(currentActor):
		advanceTurn()
		return
	
	checkBattleConditions()
	
	if currentActor.AP <= 0:
		advanceTurn()

func initializeBattle() -> void:
	turnOrder = participants.get_children()
	currentActor = turnOrder[0]
	remainingEnemies = countEnemies()

func checkBattleConditions() -> void:
	if remainingEnemies == 0:
		battleVictory = true
		isBattling = false

func advanceTurn() -> void:
	# Clean up any dead actors first
	cleanupDeadActors()
	
	# If no actors left, end battle
	if turnOrder.size() == 0:
		isBattling = false
		return
	
	# Find next valid actor
	var attempts = 0
	var originalIndex = currentTurnIndex
	
	while attempts < turnOrder.size():
		currentTurnIndex = (currentTurnIndex + 1) % turnOrder.size()
		currentActor = turnOrder[currentTurnIndex]
		
		# Skip if actor is invalid or dead
		if is_instance_valid(currentActor) and currentActor.HP > 0:
			break
		
		attempts += 1
	
	# If we didn't find a valid actor
	if attempts >= turnOrder.size():
		isBattling = false
		return
	
	# Refresh AP for new turn
	currentActor.AP = currentActor.MAX_AP
	remainingEnemies = countEnemies()

func cleanupDeadActors() -> void:
	# Remove invalid or dead actors
	for i in range(turnOrder.size() - 1, -1, -1):
		if not is_instance_valid(turnOrder[i]) or turnOrder[i].HP <= 0:
			# Adjust current index if we're removing someone before it
			if i < currentTurnIndex:
				currentTurnIndex -= 1
			turnOrder.remove_at(i)

func countEnemies() -> int:
	var count = 0
	for actor in turnOrder:
		if is_instance_valid(actor) and actor.is_in_group("enemy") and actor.HP > 0:
			count += 1
	return count

func exitCombat() -> void:
	get_tree().change_scene_to_file(previousScene)

### Debug and Signals ###
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug2"):
		battleVictory = true
		isBattling = false

func _on_battle_enemy_tree_exited() -> void:
	pass
