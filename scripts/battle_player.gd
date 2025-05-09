extends Node2D

# Stats
var HP: float = 10
var AP: int = 2
var AD: float = 10
var maxAP: int = 3

# State
enum CombatState { IDLE, TARGETING, ATTACKING }
var state: CombatState = CombatState.IDLE
var currentTarget: Node2D = null

# References
@onready var cursor: Node2D = $"../../cursor"

func _physics_process(delta: float) -> void:
	if HP <= 0:
		die()
	
	match state:
		CombatState.TARGETING:
			handleTargeting()
		CombatState.ATTACKING:
			handleAttacking()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug3"):
		AP -= 1
		print("Debug AP: ", AP)
	
	if event.is_action_pressed("cancel") and state == CombatState.TARGETING:
		resetCombatState()

func handleTargeting():
	if Input.is_action_just_pressed("select"):
		currentTarget = getTargetUnderCursor()
		if currentTarget:
			state = CombatState.ATTACKING
			print("Target acquired: ", currentTarget.name)
		else:
			print("No valid target selected")

func handleAttacking():
	if currentTarget:
		performAttack(currentTarget)
	state = CombatState.IDLE

func performAttack(target: Node2D):
	if AP <= 0:
		print("Not enough action points!")
		return
	target.HP -= AD
	print("Attacking ", target.name, "!")
	AP -= 1
	# Add damage calculation here
	currentTarget = null

func getTargetUnderCursor() -> Node2D:
	var spaceState = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = true
	
	var results = spaceState.intersect_point(query)
	if results.size() > 0:
		# Return the parent of the collider instead of the collider itself
		return results[0].collider.get_parent()
	return null

func resetCombatState():
	state = CombatState.IDLE
	currentTarget = null
	print("Targeting canceled")

func die():
	print("Unit died!")
	queue_free()

func _on_attack_pressed() -> void:
	if state == CombatState.IDLE and AP > 0:
		state = CombatState.TARGETING
		print("Select a target with left click")
	else:
		print("Can't attack now")
