extends Node

var prefab_Card = preload("res://prefabs/battle/battle_card.tscn");

var node_BattleManager: BattleManager;

const CARD_SPACING = 4;

var card_node_list: Array[Control] = [];

var is_interactable: bool = true;

# Godot functions

func _ready():
	node_BattleManager = get_node("/root/Scene");
	
	subscribe_to_broadcasters();

# Listeners

func subscribe_to_broadcasters():
	node_BattleManager.signal_CardDrawn.connect(on_card_drawn);

func on_card_drawn(card: Card):
	var new_card: Control = prefab_Card.instantiate();
	self.add_child(new_card);
	new_card.initialize(card, self);
	
	card_node_list.push_back(new_card);
	update_card_pos();

# My functions

func update_card_pos():
	var card_count: int = card_node_list.size();
	var card_dist: float = get_card_prefab_width() + CARD_SPACING;
	
	var x_start: float = -card_dist * float(card_count - 1) / 2;
	
	for i in range(0, card_node_list.size()):
		var item: Control = card_node_list[i];
		var card_target_pos = Vector2(x_start + i * card_dist, 0);
		
		item.set_position(card_target_pos);
		

# Helpers

func get_card_prefab_width() -> float:
	var card_node: Control = prefab_Card.instantiate();
	return card_node.size.x;
