extends Area2D

var scoreable : bool
var left_flower : Node
var right_flower : Node

func _ready() -> void:
	scoreable = true

func dupe_self() -> void:
	var new_left_flower : Node = Globals.flower_scene.instantiate()
	add_child(new_left_flower)
	new_left_flower.global_position.x = position.x - 6000
	left_flower = new_left_flower
	var new_right_flower : Node = Globals.flower_scene.instantiate()
	add_child(new_right_flower)
	new_right_flower.global_position.x = position.x - 6000
	right_flower = new_right_flower
