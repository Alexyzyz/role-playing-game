class_name BattleManager
extends Node

const UnitPrefab = preload("res://prefabs/unit.tscn");

@onready var hero_field = $Units/HeroField;
@onready var enemy_field = $Units/EnemyField;

@onready var canvas_turn_text = $Canvas/TurnText;

var hero_list: Array[Unit] = [];
var turn_queue: Array[Unit] = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	var hero = UnitPrefab.instantiate();
	hero.spawn("Alice", Vector3(-2, 0, 0));
	hero_field.add_child(hero);
	
	var enemy = UnitPrefab.instantiate();
	enemy.spawn("Bob", Vector3(2, 0, 0));
	enemy_field.add_child(enemy);
	
	turn_queue.append(hero);
	turn_queue.append(enemy);
	
	advance_turn();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		handle_choice(event.keycode);

func handle_choice(key: Key):
	if (key != KEY_P):
		return;
	
	for i in turn_queue.size():
		var unit: Unit = turn_queue[i];
		unit.take_damage(i);
	
	advance_turn();

func advance_turn():
	var next_unit: Unit = turn_queue.pop_back();
	canvas_turn_text.text = "It is now " + next_unit.unit_name + "'s turn.";
	turn_queue.push_front(next_unit);
