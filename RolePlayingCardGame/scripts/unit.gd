class_name Unit
extends Node

@onready var hp_bar: Sprite3D = $Health;
@onready var name_text: Label3D = $NameText;

var unit_name: String;
var hp_max: int;
var hp: int;

func _ready():
	name_text.text = unit_name;

func spawn(name: String, spawn_position: Vector3):
	unit_name = name;
	hp_max = 10;
	hp = hp_max;

func take_damage(damage: int):
	hp -= damage;
	hp = max(hp, 0);
	hp_bar.scale.x = float(hp) / float(hp_max);
