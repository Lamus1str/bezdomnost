extends Area2D
class_name Interaction_object

signal is_interaction(agent: Player, interact: int, delta: float)

var is_mouse_in = false

@export var builded_or_assigned = false
var destroy_from_damn = 0.0
@export var endurance = 20.0

func _mouse_enter():
	is_mouse_in = true
	print("asadasd")
func  _mouse_exit():
	is_mouse_in = false
	

enum INTERACT{
	PRESENCE = 1,
	ACTION_PRESSED = 2,
	DESTROY = 4,
	
}


func interaction(agent: Player, interact: int, delta: float):
	is_interaction.emit(agent, interact, delta)
	pass
