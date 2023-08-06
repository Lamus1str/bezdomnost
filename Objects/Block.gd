extends Interaction_object
class_name Block

# Called when the node enters the scene tree for the first time.
var destroy_from_player = 0
@export var destroying_level: int = 0
@export var drop_items = []

func destroy_interaction(agent: Player, interact: int, delta):
	if interact & INTERACT.DESTROY and agent.destroing_level >= destroying_level:
		destroy_from_player += agent.destroing_speed * delta
		if destroy_from_player >= endurance:
			for item in drop_items:
				Global.drop(position, item)
			queue_free()
			pass

func interaction(agent: Player, interact: int, delta):
	destroy_interaction(agent, interact, delta)
	pass
