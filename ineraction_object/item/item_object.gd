extends Interaction_object

@export var loaded_item: Resource
var item: Item
# Called when the node enters the scene tree for the first time.
func _ready():
	if loaded_item is Item:
		set_item(loaded_item)
	endurance = 20.0
	builded_or_assigned = true
	pass # Replace with function body.

func set_item(_item: Item):
	item = _item
	if item:
		$Sprite.texture = item.icon

func interaction(agent, interact, delta):
	if (interact & INTERACT.ACTION_PRESSED):
		print(interact)
		if agent.add_item(item):
			queue_free()
	pass
