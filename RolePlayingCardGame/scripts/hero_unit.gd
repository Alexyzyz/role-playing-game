extends Node

var hp_bar: Sprite3D;

var hp_max: int;
var hp: int;

# Called when the node enters the scene tree for the first time.
func _ready():
	hp_bar = $Sprite3D;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn(spawn_position: Vector3):
	hp_max = 10;
	self.position = spawn_position;

func take_damage(damage: int):
	hp -= damage;
	hp_bar.scale.x = hp / hp_max;
