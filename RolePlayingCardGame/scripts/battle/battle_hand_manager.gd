extends Node

const CARD_SPACING = 4;

var CardPrefab = preload("res://prefabs/battle/battle_card.tscn");

var card_node_list: Array[Control] = [];

var is_interactable: bool = true;

# Godot functions

func _ready():
	subscribe_to_broadcasters();

# Listeners

func subscribe_to_broadcasters():
	var scr_battle_manager = get_node("/root/Scene");
	scr_battle_manager.card_drawn.connect(on_card_drawn);

func on_card_drawn(card: Card):
	var new_card: Control = CardPrefab.instantiate();
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
		item.position.x = x_start + i * card_dist;
		

# Helpers

func get_card_prefab_width() -> float:
	var card_node: Control = CardPrefab.instantiate();
	return card_node.size.x;
