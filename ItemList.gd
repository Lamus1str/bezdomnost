extends ItemList


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_player_update_items(new_items):
	clear()
	for i in new_items:
		if i is Item:
			add_item("{name} ({count})".format({"name": i.name, "count": i.count}), i.icon)
	pass # Replace with function body.
