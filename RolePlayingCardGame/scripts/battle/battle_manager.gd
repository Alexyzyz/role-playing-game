class_name BattleManager
extends Node

signal signal_CardDrawn(card: Card);

const prefab_Unit = preload("res://prefabs/battle/battle_unit.tscn");

@onready var node_BattleHandManager = $Canvas/Hand;
@onready var node_DrawPile = $Canvas/DrawPile;

@onready var node_HeroField = $Units/HeroField;
@onready var node_EnemyField = $Units/EnemyField;

@onready var node_CanvasTurnText = $Canvas/TurnText;

var hero_list: Array[Unit] = [];
var enemy_list: Array[Unit] = [];
var is_player_turn: bool = true;
# var turn_queue: Array[Unit] = [];

var draw_pile: Array[Card] = [];
var hand: Array[Card] = [];
var discard_pile: Array[Card] = [];

var rng = RandomNumberGenerator.new();

# Called when the node enters the scene tree for the first time.
func _ready():
	var hero = prefab_Unit.instantiate();
	hero.initialize("Alice", Vector3(-2, 0, 0));
	hero_list.push_back(hero);
	node_HeroField.add_child(hero);
	
	var enemy = prefab_Unit.instantiate();
	enemy.initialize("Bob", Vector3(2, 0, 0));
	enemy_list.push_back(enemy);
	node_EnemyField.add_child(enemy);
	
	populate_draw_pile();
	draw_n_cards(1);

func _process(_delta):
	debug();

func _input(event):
	if event is InputEventKey and event.pressed:
		handle_choice(event.keycode);

func handle_choice(key: Key):
	if (key != KEY_P):
		return;
	
	if is_player_turn:
		enemy_list[0].take_damage(1);
	else:
		hero_list[0].take_damage(1);
	is_player_turn = !is_player_turn;
	
	advance_turn();

func advance_turn():
	var active_party: String = "player" if is_player_turn else "enemy";
	node_CanvasTurnText.text = "It is now the " + active_party + " party's turn.";

func populate_draw_pile():
	for i in range(0, 30):
		var card_type_index: int = rng.randi_range(0, 1);
		match card_type_index:
			0: draw_pile.push_back(CardBasic.new());
			1: draw_pile.push_back(CardScratch.new());
			_: draw_pile.push_back(CardBasic.new());

func draw_n_cards(n: int):
	for i in range(0, n):
		draw_from_pile();
	
func draw_from_pile():
	if draw_pile.size() == 0:
		return;
	
	var drawn_card: Card = draw_pile.pop_back();
	hand.push_back(drawn_card);
	
	signal_CardDrawn.emit(drawn_card);

# Debug functions

func debug():
	debug_test_draw();

func debug_test_draw():
	if not Input.is_action_just_pressed("debug_q"):
		return;
	draw_from_pile();
