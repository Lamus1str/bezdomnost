extends CharacterBody2D
class_name Player

signal Update_items(new_items: Array)
signal Update_items_in_box(new_items: Array)

signal Update_craft_list(new_craft_list: Array)
signal Update_craft_components(new_craft_components: Array)

const SPEED = 200.0
const SPEED_UP = 1800.0

const MAX_DISTANCE_TO_USE = 200.0

var hp = 450

func damage(dm):
	hp -= dm
	

const HAND_DESTROY_LEVEL = 0
const HAND_DESTROY_SPEED = 15
var destroing_level = HAND_DESTROY_LEVEL
var destroing_speed = HAND_DESTROY_SPEED

var opened_box = null
var items = []
const MAX_ITEMS_COUNT = 6
var selected_item = -1
var box_selected_item = -1

var crafts = []
var selected_craft = -1

var speed_coff = 1.0
var speed_up_coff = 1.0

var nearest_object_mouse = null

func update_craft():
	if selected_craft != -1 and selected_craft < crafts.size():
		var craft_obj = crafts[selected_craft]
		if craft_obj is ResipeCraft:
			Update_craft_components.emit(craft_obj.input)

func update_box():
	if opened_box != null:
		if opened_box is Node2D:
			if (opened_box.global_position - global_position).length_squared() > MAX_DISTANCE_TO_USE ** 2:
				opened_box = null
				Update_items_in_box.emit([])
		if opened_box is Box:
			if box_selected_item < opened_box.items.size() and box_selected_item != -1:
				if Input.is_action_just_pressed("Player_storing"):
					add_item(opened_box.items[box_selected_item])
					opened_box.remove_from_box(box_selected_item)
					Update_items.emit(items)
					Update_items_in_box.emit(opened_box.items)
			elif selected_item < items.size() and selected_item != -1:
				if Input.is_action_just_pressed("Player_storing"):
					opened_box.add_to_box(items[selected_item])
					items.pop_at(selected_item)
					Update_items.emit(items)
					Update_items_in_box.emit(opened_box.items)
			
		

func update_mouse():
	nearest_object_mouse = null
	var shortest_s = -1
	for area in $mouse_area.get_overlapping_areas():
		if area is Interaction_object:
			var i_s = ($mouse_area.global_position - area.global_position).length()
			if i_s < shortest_s or shortest_s == -1:
				shortest_s = i_s
				nearest_object_mouse = area

func update_interaction(delta):
	for area in $Interacton_area.get_overlapping_areas():
		if area is Interaction_object:
			var interact = 1
			if area == nearest_object_mouse and Input.is_action_pressed("Player_interaction"):
				interact = interact | Interaction_object.INTERACT.ACTION_PRESSED
			if area == nearest_object_mouse and Input.is_action_pressed("Player_destroing"):
				interact = interact | Interaction_object.INTERACT.DESTROY
			area.interaction(self, interact, delta)

func drop_item(i: int):
	if items.size() > i:
		var item_obj = preload("res://ineraction_object/item/item_object.tscn").instantiate()
		item_obj.set_item(items[i])
		item_obj.loaded_item = items[i]
		item_obj.position = position + get_local_mouse_position().normalized() * 60
		Global.World.add_child(item_obj)
		items.pop_at(i)
		selected_item = 0
		Update_items.emit(items)

func add_item(added_item: Item):
	if items.size() == MAX_ITEMS_COUNT:
		return 0
	#if added_item in items:
		#print(items.find(added_item))
		#items[items.find(added_item)].count += 1
	else:
		items.append(added_item)
	Update_items.emit(items)
	return 1

func items_update(delta):
	if selected_item < items.size() and selected_item != -1:
		if Input.is_action_just_pressed("Player_drop_item") and Global.inventory_opened:
			drop_item(selected_item)
		elif items[selected_item] is UsableItem:
			if items[selected_item].single_use && items[selected_item].use_item(self, get_global_mouse_position()):
				items.pop_at(selected_item)
				Update_items.emit(items)
			pass

func _ready():
	Global.player = self
	
	items.append(load("res://Items/red_square.tres"))
	Update_items.emit(items)
	
	crafts = [ ResipeCraft.new(["wood", "wood", "wood", "wood"], "tree_wall"),
	ResipeCraft.new(["wood", "stone"], "stone picksaw"),
	ResipeCraft.new(["stone", "stone", "stone", "stone"], "stone wall"),
	ResipeCraft.new(["wood", "iron", "iron"], "iron picksaw"),
	ResipeCraft.new(["kakaeto fignya", "fignya", "strannaya fignya"], "super puper apple"),
	ResipeCraft.new(["wood", "wood", "wood", "wood"], "box"),]
	
	Update_craft_list.emit(crafts)

func get_input_dir() -> Vector2:
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("Player_left", "Player_right")
	direction.y = Input.get_axis("Player_up", "Player_down")
	return direction

var damn_sc = preload("res://damn/damn.tscn")
func damn_update():
	for obj in $damn.get_overlapping_areas():
		if obj is Interaction_object:
			if obj.builded_or_assigned and not(obj in Global.damned):
				var new_damn = damn_sc.instantiate()
				new_damn.set_obj(obj)
				Global.World.add_child(new_damn)
				Global.damned.append(obj)

func move_process(delta):
	var direction = get_input_dir().normalized()
	if direction != Vector2.ZERO:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
	velocity = velocity.move_toward(direction * SPEED * speed_coff, SPEED_UP * delta * speed_up_coff)

func _physics_process(delta):
	
	$mouse_area.position = get_local_mouse_position()
	if Global.inventory_opened:
		update_box()
		update_craft()
	destroing_speed = HAND_DESTROY_SPEED
	destroing_level = HAND_DESTROY_LEVEL
	items_update(delta)
	update_mouse()
	update_interaction(delta)
	damn_update()
	
	move_process(delta)
	
	move_and_slide()


func _on_item_list_item_selected(index):
	selected_item = index
	pass # Replace with function body.


func _on_item_list_empty_clicked(at_position, mouse_button_index):
	selected_item = -1
	pass # Replace with function body.


func _box_item_selected(index):
	box_selected_item = index
	pass # Replace with function body.


func _box_empty_clicked(at_position, mouse_button_index):
	box_selected_item = -1
	pass # Replace with function body.


func _craft_pressed():
	if selected_craft != -1 and selected_craft < crafts.size():
		var craft_obj = crafts[selected_craft]
		if craft_obj is ResipeCraft:
			if craft_obj.craft_conditinal(self):
				craft_obj.craft(self)
	pass # Replace with function body.


func _on_crafts_selected(index):
	selected_craft = index
	pass # Replace with function body.
