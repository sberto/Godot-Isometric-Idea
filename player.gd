extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera = $Camera3D

func _physics_process(delta: float) -> void:
	var speed = 5
	velocity.y -= gravity * delta

	# Get the input direction.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = camera.basis * Vector3(direction.x, 0., direction.y) * speed
	velocity.y = 0

	move_and_slide()
