extends Area2D

var scoreable : bool
var left_flower : Node
var right_flower : Node
var points : int = 10

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

func display_score(multiplier : int):
	var number = get_node("Label")
	number.text = str("+",points * multiplier)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	number.label_settings.font_color = "#0F3"
	number.label_settings.font_size = 35
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.6
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.3 
	).set_ease(Tween.EASE_IN).set_delay(0.4)
	
	await tween.finished
	number.queue_free()
