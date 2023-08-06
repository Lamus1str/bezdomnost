extends  UsableItem
class_name Picksaw

@export var level = 0
@export var speed = 100

func use_item(agent: Player, position: Vector2) -> bool:
	agent.destroing_level = level
	agent.destroing_speed = speed
	return false
	pass
