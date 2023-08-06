extends ItemList


func _on_player_update_craft_list(new_craft_list):
	clear()
	for craft in new_craft_list:
		if craft is ResipeCraft:
			var i = Global.items_from_name[craft.output]
			if i is Item:
				add_item("{name} ({count})".format({"name": i.name, "count": i.count}), i.icon)
		else:
			print(craft.get_class())
	pass # Replace with function body.

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
