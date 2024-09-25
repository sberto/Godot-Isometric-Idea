extends CharacterBody3D

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up")
	velocity.x = input.x
	velocity.z = input.y
	velocity *= 10
	move_and_slide()
