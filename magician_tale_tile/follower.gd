extends Camera3D

@export var target: Node3D
@onready var offset := position - target.position

func _physics_process(delta: float) -> void:
	position = target.position + offset
