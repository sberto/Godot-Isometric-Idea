extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var current_index = null
@onready var grid = $GridMap.get_used_cells()
var block_scn = preload("res://block2.tscn")
var radius = Globals.radius
var grid_size = int(radius * 1.5)
var index_to_blocks_map: Dictionary = {}
var spawned_blocks: Dictionary = {}

func _ready() -> void:
	_blocks_map()

func _blocks_map():
	for b in grid:
		var index = _block_index(b)
		var value: Array = index_to_blocks_map.get_or_add(index, [])
		value.append(b)
		index_to_blocks_map[index] = value

func _physics_process(_delta: float) -> void:
	var new_index = _block_index(player.position)
	
	var directions: Array = [Vector3.UP, Vector3.DOWN, Vector3.LEFT, Vector3.RIGHT, Vector3.FORWARD, Vector3.BACK]
	for d in directions:
		var direction_block_index = _block_index(player.position + d * radius)
		if current_index == direction_block_index:
			var far_block_index = _block_index(player.position + d * grid_size)
			if far_block_index != current_index:
				_despawn(far_block_index)
				spawned_blocks.erase(far_block_index)
				
	var d = player.velocity.normalized()
	var direction_block_index = _block_index(player.position + d * grid_size)
	if not spawned_blocks.has(direction_block_index):
		if direction_block_index != current_index:
			_for_each_block(direction_block_index, _spawn)
			spawned_blocks[direction_block_index] = true
	current_index = new_index

func _block_index(position):
	var x = floori(position.x) / grid_size
	var y = floori(position.y) / grid_size
	var z = floori(position.z) / grid_size
	return Vector3(x,y,z)

func _for_each_block(index, fun):
	if index_to_blocks_map.has(index):
		var to_spawn = index_to_blocks_map[index]
		for b in to_spawn:
			fun.call(b)

func _spawn(block_pos):
	var block = block_scn.instantiate()
	block.position = block_pos
	block.player = player
	add_child(block)

func _despawn(index):
	for b in get_tree().get_nodes_in_group("block"):
		if _block_index(b.position) == index:
			b.queue_free()
