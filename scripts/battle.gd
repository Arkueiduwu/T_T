extends CanvasLayer

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug1"):
		exitCombat()
		
func startCombat():
	visible = true
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_DISABLED
	
	
func exitCombat():
	visible = false
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
	
	
