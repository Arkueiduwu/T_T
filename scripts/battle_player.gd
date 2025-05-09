extends Node2D

### Combat Stats ###
var HP: float = 10.0
var AP: int = 2
var AD: float = 10.0
const MAX_AP: int = 3

### Targeting ###
var currentTarget: Node2D = null
var current_action: String = ""

func _physics_process(_delta: float) -> void:
	if HP <= 0:
		queue_free()
	if current_action and Input.is_action_just_pressed("select"):
		currentTarget = get_target_under_mouse()
		if currentTarget:
			execute_action()

func execute_action() -> void:
	if AP <= 0:
		print("Out of AP!")
		return
	
	match current_action:
		"attack":
			currentTarget.HP -= AD
			print("Dealt ", AD, " damage to ", currentTarget.name)
		"heal":
			currentTarget.HP += 5
			print("Healed ", currentTarget.name, " for 5 HP")
		"item":
			print("Used item on ", currentTarget.name)
	
	AP -= 1
	reset_action()

func get_target_under_mouse() -> Node2D:
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	var result = space.intersect_point(query)
	return result[0].collider.get_parent() if result else null

func reset_action() -> void:
	current_action = ""
	currentTarget = null

func _on_attack_pressed() -> void: current_action = "attack"
func _on_heal_pressed() -> void: current_action = "heal"
func _on_item_pressed() -> void: current_action = "item"
