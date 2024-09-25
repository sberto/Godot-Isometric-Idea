extends Area3D

func _ready() -> void:
	$AnimationPlayer.play_backwards("in")

func _on_area_exited(area: Area3D) -> void:
	print("in with %s" % area.name)
	match area.name:
		"Smaller":
			$AnimationPlayer.play("wobble")
		"Larger":
			$AnimationPlayer.play("in")

func _on_area_entered(area: Area3D) -> void:
	print("out with %s" % area.name)
	match area.name:
		"Smaller":
			$AnimationPlayer.play("RESET")
		"Larger":
			$AnimationPlayer.play_backwards("in")
