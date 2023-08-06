extends CharacterBody2D

var hp = 100

var delay = 4.0

func _physics_process(delta):
	var coll = get_last_slide_collision()
	delay = move_toward(delay, 0.0, delta)
	if coll and delay == 0.0:
		var collider = coll.get_collider()
		if collider is Player:
			collider.damage(10)
			delay = 4
	velocity = (Global.player.global_position - global_position).normalized() * 30
	move_and_slide()


func is_interaction(agent, interact, delta):
	#print("fsdf")
	if interact & Interaction_object.INTERACT.DESTROY:
		hp -= 20
		if hp <= 0:
			Global.enemies_n -= 1
			queue_free()
	pass # Replace with function body.
