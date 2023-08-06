extends Block
class_name Box

var items = []
@export var items_max = 10

func interaction(agent: Player, interact: int, delta):
	destroy_interaction(agent, interact, delta)
	if interact & INTERACT.ACTION_PRESSED:
		agent.opened_box = self
		agent.Update_items_in_box.emit(items)
		Global.inventory_opened = true
		Global.inventory_open.emit()
	pass

func add_to_box(item: Item) -> bool:
	if items.size() < items_max:
		items.append(item)
		return true
	return false
	
func remove_from_box(item_id: int):
	if item_id < items.size():
		items.pop_at(item_id)

