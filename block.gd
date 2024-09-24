extends Node3D
class_name Block

@onready var anim: AnimationTree = $AnimationTree
@onready var radius: float = Globals.radius
@export var player: Node3D

var hidden = true
var t: Tween

func _ready():
	$MeshInstance3D.material_override.albedo_color = Color(0,0,0,0)
	hidden = true

func _physics_process(delta: float) -> void:
	if _player_distance() > radius + 1:
		if hidden:
			anim["parameters/playback"].start("out")
			hidden = false
	else:
		if not hidden:
			anim["parameters/playback"].start("Start")
			anim["parameters/playback"].travel("resting")
			$MeshInstance3D.material_override.albedo_color = Color(.1,.1,.1,1.)
			hidden = true

func _player_distance():
	return (player.position - position).length()
