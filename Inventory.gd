extends Control

func _ready():
	Global.inventory_open.connect(Callable(self, "show"))
	Global.inventory_close.connect(Callable(self, "hide"))
	pass # Replace with function body.
