extends Camera3D

func _process(delta: float) -> void:
	look_at($"..".position)
