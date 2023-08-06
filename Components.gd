extends ItemList


func _on_player_update_craft_components(new_craft_components):
	clear()
	for component in new_craft_components:
		var i = Global.items_from_name[component]
		if i is Item:
			add_item("{name} ({count})".format({"name": i.name, "count": i.count}), i.icon)
	pass # Replace with function body.

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
