extends CharacterBody2D
var directional_input: Vector2 = Vector2.ZERO
var speed: int = 300
@onready var sprite_sheet: AnimatedSprite2D = $spriteSheet
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
					sprite_sheet.play("walkRight")
				else:
					sprite_sheet.play("walkLeft")
			else:
				if directional_input.y > 0:
					sprite_sheet.play("walkDown")
				else:
					sprite_sheet.play("walkUp")
		MovementState.IDLE:
			sprite_sheet.play("idleDown")
			sprite_sheet.frame = 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		battleScene.startCombat()
		
		
