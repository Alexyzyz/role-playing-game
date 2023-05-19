extends Area3D

@onready var anim_player = $AnimationPlayer


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node3D):
	anim_player.play("move")


func _on_body_exited(body: Node3D):
	anim_player.play("move")
	print("hey!")

