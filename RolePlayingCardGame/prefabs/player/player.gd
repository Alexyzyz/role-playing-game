extends CharacterBody3D

const MAX_SPEED = 3
const ACCELERATION = 20



func _process(delta):
	var move_direction = Vector3.ZERO
	move_direction.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction = move_direction.normalized()
	
	var target_speed = move_direction * MAX_SPEED
	velocity = velocity.lerp(target_speed, 1 - exp(-delta * ACCELERATION))
	move_and_slide()
