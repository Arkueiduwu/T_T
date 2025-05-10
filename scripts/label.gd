extends Label

### Nodes ###
@onready var timer: Timer = $Timer

### Movement Properties ###
var velocity: Vector2 = Vector2(1, -1).normalized() * 200
var friction: float = 0.85
var gravity: Vector2 = Vector2(0, 100)

### Lifecycle ###
func _ready() -> void:
	# Randomize movement slightly
	velocity = velocity.rotated(randf_range(-0.2, 0.2))
	friction = clamp(friction + randf_range(-0.05, 0.05), 0.7, 0.95)
	
	# Start countdown
	timer.start()

func _physics_process(delta: float) -> void:
	# Update position
	position += velocity * delta
	
	# Apply physics
	velocity += gravity * delta
	velocity *= friction
	
	# Fade out effect tied to timer
	modulate.a = timer.time_left / timer.wait_time
	
	# Optional shrink effect
	scale = Vector2.ONE * modulate.a

func _on_timer_timeout() -> void:
	queue_free()
