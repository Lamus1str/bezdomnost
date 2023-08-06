extends Item
class_name UsableItem

@export var single_use = false

func use_item(agent: Player, position: Vector2) -> bool:
	return false
	pass
