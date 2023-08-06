extends Node

var player: Player = null
var random_gen = RandomNumberGenerator.new()

signal inventory_open()
signal inventory_close()

var enemies_n = 0


var World: Node2D

var items_from_name = {}
var objects_scenes_from_name = {}

var inventory_opened = true

var damned = []

func random_position():
	return Vector2(random_gen.randi_range(-5000, 5000), random_gen.randi_range(-500, 500))
	
func restart():
	get_tree().change_scene_to_file("res://main.tscn")
	pass


func _ready():
	
	items_from_name = preload("res://Items/all_items.tres").get_meta("from_name")
	objects_scenes_from_name = preload("res://Objects/all_object_scenes.tres").get_meta("from_name")

func drop(position: Vector2, item: Item):
	var drop = preload("res://ineraction_object/item/item_object.tscn").instantiate()
	drop.position = position
	drop.set_item(item)
	World.add_child(drop)

var enemy = preload("res://damn/enemies/enemy_0.tscn")

func _process(delta):
	if enemies_n < 10:
		enemies_n+= 1
		var new_enemy = enemy.instantiate()
		new_enemy.position = random_position()
		World.add_child(new_enemy)
		
	
	if Input.is_action_just_pressed("inventory_close_open"):
		if not(inventory_opened):
			inventory_open.emit()
			inventory_opened = true
		else:
			inventory_close.emit()
			inventory_opened = false
	
