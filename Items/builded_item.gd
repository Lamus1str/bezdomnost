extends UsableItem
class_name BuildedItem

@export var scene_name: String
var detoroy_from_damn = 0

func use_item(agent, position):
	if Input.is_action_just_pressed("Player_build"):
		if (agent.global_position - position).length() <= Player.MAX_DISTANCE_TO_USE:
			var build_obj = Global.objects_scenes_from_name[scene_name].instantiate()
			build_obj.position = position - Global.World.global_position
			build_obj.builded_or_assigned = true
			Global.World.add_child(build_obj)
			return true
		pass
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
