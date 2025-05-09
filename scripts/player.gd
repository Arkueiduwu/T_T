extends CharacterBody2D

var speed: int = 300
var hp: float = 10

var directional_input: Vector2 = Vector2.ZERO

@onready var spriteSheet: AnimatedSprite2D = $spriteSheet
@onready var battleScene: CanvasLayer = $"../Combat"

enum MovementState {IDLE, WALKING, RUNNING}
var current_state = MovementState.IDLE

func _physics_process(delta: float) -> void:
	handleMovementInput(delta)
	move_and_slide()
	play_animation()
	
func handleMovementInput(delta: float):
	directional_input = Input.get_vector("left", "right", "up", "down").normalized()
	
	if directional_input != Vector2.ZERO:
		current_state = MovementState.WALKING
	else:
		current_state = MovementState.IDLE
		
	velocity = directional_input * speed

func play_animation():
	match current_state:
		MovementState.WALKING:
			if abs(directional_input.x) > abs(directional_input.y):
				if directional_input.x > 0:
					spriteSheet.play("walkRight")
				else:
					spriteSheet.play("walkLeft")
			else:
				if directional_input.y > 0:
					spriteSheet.play("walkDown")
				else:
					spriteSheet.play("walkUp")
		MovementState.IDLE:
			spriteSheet.play("idleDown")
			spriteSheet.frame = 0
		
		
