extends Node3D

const ROOM_SIZE = Vector3(10, 0, 8)

@export var room_scenes: Array[PackedScene]

var room_locations = [Vector3(1,0,1)]
var random_rotation = [PI/2, 0,-PI/2]
var current_room_position = Vector3(8,0,8)
var room_amount = 10
var room_direction = Vector3.RIGHT

func _ready():
	randomize()
	if room_scenes == null:
		return
	
	generate_room(current_room_position)
	var iteration = 1
	
	while iteration < room_amount:
		var random_rot = random_rotation.pick_random()
		room_direction = room_direction.rotated(Vector3.UP, random_rot)
		var next_position = current_room_position + room_direction
		if next_position in room_locations:
			next_position = current_room_position + room_direction
			continue
		elif not next_position in room_locations:
			room_locations.append(next_position)
			generate_room(next_position)
			current_room_position = next_position
			iteration += 1
	print(room_locations.size())
	print(room_locations)


func generate_room(room_position):
	if room_scenes == null:
		return
	var room = room_scenes.pick_random().instantiate() as Node3D
	add_child(room)
	room.global_position = room_position * ROOM_SIZE
	
