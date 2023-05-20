extends Node

@onready var node_hover_area: TextureRect = $HoverArea;
@onready var node_title: Label = $Content/Title;
@onready var node_cost: Label = $Cost;
@onready var node_image: TextureRect = $Content/Image;

signal on_selected;

const HOVERED_SCALE_VAL = 1.1;
const HOVERED_ALPHA = 0.5;
const HOVER_TWEEN_DURATION = 0.05;

var model: Card;
var parent_container: Control;

var is_hovered: bool;

# Godot functions

func _ready():
	subscribe_to_broadcasters();
	set_is_hovered(false);

func _process(_delta):
	pass;

func on_mouse_entered():
	set_is_hovered(true);

func on_mouse_exited():
	set_is_hovered(false);

# Listeners

func subscribe_to_broadcasters():
	connect("mouse_entered", on_mouse_entered);
	connect("mouse_exited", on_mouse_exited);

# My functions

func initialize(_model: Card, _parent_container: Control):
	model = _model;
	parent_container = _parent_container;
	
	node_cost.text = str(model.cost);
	node_title.text = model.title;

func is_interactable() -> bool:
	return true;

func set_is_hovered(_is_hovered: bool):
	is_hovered = _is_hovered;
	
	var card_scale_val: float = HOVERED_SCALE_VAL if is_hovered else 1.0;
	var card_scale: Vector2 = card_scale_val * Vector2.ONE;
	
	var tween = self.create_tween();
	tween.tween_property(
		self, "scale",
		card_scale,
		HOVER_TWEEN_DURATION);
	
	var hovered_modulate: Color = self.modulate;
	hovered_modulate.a = HOVERED_ALPHA if not is_hovered else 1.0;
	tween.parallel().tween_property(
		self, "modulate",
		hovered_modulate,
		HOVER_TWEEN_DURATION);

