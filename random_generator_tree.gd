extends Node

func random_generate(scene: PackedScene, n: int):
	for i in range(n):
		var i_scene = scene.instantiate()
		i_scene.position = Global.random_position()
		Global.World.add_child(i_scene)

func _ready():
	var tree = preload("res://Objects/can_extract/tree/tree.tscn")
	var stone = preload("res://Objects/can_extract/ore/stone.tscn")
	var iron = preload("res://Objects/can_extract/ore/iron.tscn")
	random_generate(tree, 100)
	random_generate(stone, 60)
	random_generate(iron, 40)
	
	
