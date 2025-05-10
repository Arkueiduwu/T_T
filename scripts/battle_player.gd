extends Node2D

@onready var battleNode: Node2D = $"../.."

@export var stats: Dictionary = {
	"HP": {"value": 10.0, "min": 0.0, "max": 10.0, "type": "float"},
	"AP": {"value": 1, "min": 0, "max": 1, "type": "int"},
	"AD": {"value": 5.0, "min": 0.0, "max": INF, "type": "float"}
}

var currentTarget: Node2D = null
var current_action: String = ""

func _physics_process(_delta: float) -> void:
	if stats["HP"]["value"] <= 0:
		queue_free()
	if current_action and Input.is_action_just_pressed("select"):
		currentTarget = get_target_under_mouse()
		if currentTarget:
			execute_action()

func execute_action() -> void:
	if stats["AP"]["value"] <= 0:
		print("Out of AP!")
		return
	
	match current_action:
		"attack":
			changeStat(currentTarget, "HP", -stats["AD"]["value"])
			print("Dealt ", stats["AD"]["value"], " damage to ", currentTarget.name)
		"heal":
			currentTarget.HP += 5
			print("Healed ", currentTarget.name, " for 5 HP")
		"item":
			print("Used item on ", currentTarget.name)
	
	stats["AP"]["value"] -= 1
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

func changeStat(target: Node2D, stat: String, amount: float) -> void:
	if not target or not target.stats.has(stat):
		push_error("Invalid target or stat: " + stat)
		return
	
	# Get the stat configuration
	var stat_config = target.stats[stat]
	
	# Apply change based on type
	match stat_config.type:
		"int":
			target.stats[stat].value = clampi(
				int(target.stats[stat].value + amount),
				stat_config.min,
				stat_config.max
			)
		"float":
			target.stats[stat].value = clampf(
				target.stats[stat].value + amount,
				stat_config.min,
				stat_config.max
			)
	var amountToString: String = "%.0f" % amount
	battleNode.showlabel(target.position, amountToString)
	
	print("Changed %s by %.1f (now: %s)" % [
		stat, 
		amount, 
		target.stats[stat].value
	])

func _on_attack_pressed() -> void: current_action = "attack"
func _on_heal_pressed() -> void: current_action = "heal"
func _on_item_pressed() -> void: current_action = "item"
