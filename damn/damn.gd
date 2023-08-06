extends Node2D
class_name Damn

@export var damn_speed = 0.5
var obj: Node2D

func set_obj(_obj):
	obj = _obj
	position = obj.position + Vector2(0, 10)
	$AnimationPlayer.play("foo")

func _physics_process(delta):
	if obj != null:
		if obj is Interaction_object:
			obj.destroy_from_damn += damn_speed * delta
			if obj.destroy_from_damn >= obj.endurance:
				if Global.damned is Array:
					Global.damned.erase(obj)
				obj.queue_free()
				queue_free()
			pass
	else:
		queue_free()
