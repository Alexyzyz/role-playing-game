extends Node
const HeroUnit = preload("hero_unit.gd");

var hero_list: Array[HeroUnit] = [];
var turn_queue: Array[HeroUnit] = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	var hero: HeroUnit = HeroUnit.new();
	hero.spawn(Vector3(-2, 0, 0));
	
	var enemy: HeroUnit;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
