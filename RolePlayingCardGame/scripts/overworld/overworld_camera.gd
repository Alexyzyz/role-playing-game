extends Camera3D

var target_position = Vector3.ZERO
var offset = Vector3(0, 1.5, 3.0)

func _ready():
	make_current()

func _process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 10))

func acquire_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node3D
		target_position = player.global_position + offset #* Vector3(8,10,8)
