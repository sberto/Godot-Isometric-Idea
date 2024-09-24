extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
	var speed = 1
	velocity.y -= gravity * delta

	# Get the input direction.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = Vector3(direction.x + direction.y, 0, - direction.x + direction.y) * 3.

	move_and_slide()
