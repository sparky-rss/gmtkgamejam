extends Node

var flower_scene : PackedScene = preload("res://Scenes/Flower.tscn")
var hornet_scene : PackedScene = preload("res://Scenes/hornet.tscn")
var unscored_flowers : int
var you_win : bool = false
var game_over : bool = false
var level : int = 1
@export var player : Node
@export var global_timer : Node

func start_next_level() -> void:
	you_win = false
	level += 1
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func retry() -> void:
	game_over = false
	level = 1
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
