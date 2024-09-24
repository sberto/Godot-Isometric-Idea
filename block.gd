extends StaticBody3D

@onready var player: Node3D = get_tree().get_first_node_in_group("player")

enum State {INVISIBLE, VISIBLE}
var state: State = State.VISIBLE

var radius = 7
@onready var final_position = global_position

@onready var anim: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	position.y = final_position.y + sin(Time.get_ticks_msec() / 1000. + final_position.x / 3.)
	
	if not player: 
		player = get_tree().get_first_node_in_group("player")
		return
	
	var distance: Vector3 = player.global_position - global_position	
	
	match state:
		State.INVISIBLE:
			if distance.length() < radius:
				$MeshInstance3D.visible = true
				position += (position - player.position) * 10.
				
				var tween = get_tree().create_tween()
				tween\
				.tween_property(self, "position", final_position, .5)\
				.set_trans(Tween.TRANS_EXPO)
				
				tween\
				.tween_callback(change_state.bind(State.VISIBLE))
				
				anim.play("in")
		State.VISIBLE:
			if distance.length() >= radius + 5:
				anim.play_backwards("in")
				var tween = get_tree().create_tween()
				tween.tween_interval(1)
				tween.tween_callback(change_state.bind(State.INVISIBLE))

func change_state(new_state: State):
	state = new_state
	if new_state == State.INVISIBLE:
		$MeshInstance3D.visible = false
