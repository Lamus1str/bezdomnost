extends Resource
class_name ResipeCraft

@export var input: PackedStringArray
@export var output: String
var using_items_id = []
var using_box_items_id = []
var crafted = false

func _init(_input: Array, _output: String):
	input = PackedStringArray(_input)
	output = _output
	

func craft_conditinal(agent: Player) -> bool:
	using_items_id = []
	using_box_items_id = []
	
	for component in input:
		var found = false
		for id_item in range(agent.items.size()):
			if agent.items[id_item].name == component and not(id_item in using_items_id):
				found = true
				using_items_id.append(id_item)
				break
		if agent.opened_box and not(found):
			for id_item in range(agent.opened_box.items.size()):
				if agent.opened_box.items[id_item].name == component and not(id_item in using_box_items_id):
					found = true
					using_box_items_id.append(id_item)
					break
		if not(found):
			return false
	crafted = false
	return true
		
	

func craft(agent: Player):
	if not(crafted):
		for i in using_items_id:
			agent.items.pop_at(i)
		for i in using_box_items_id:
			agent.opened_box.items.pop_at(i)
		
		agent.add_item(Global.items_from_name[output])
		
		if using_items_id:
			agent.Update_items.emit(agent.items)
		if using_box_items_id:
			agent.Update_items_in_box.emit(agent.opened_box.items)
		
	crafted = true
	pass
