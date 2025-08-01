extends CanvasLayer

var bumble_up : bool = true
var wing_bumble_up : bool = true
var bumble : float = 0
var wing_bumble : float = 0

func _ready() -> void:
	SoundManager.init_sound_system()
	var title_node = get_node("MenuBackground/Label")
	title_node.text = str("[font_size=50][rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]Loop-Bee-Loop[/wave][/rainbow][/font_size]")
	var start_button = get_node("StartGame")
	var quit_button = get_node("Quit")
	var instructions_button = get_node("HowToPlay")
	var credits_button = get_node("Credits")
	var high_score_button = get_node("HighScores")
	style_that_box(start_button)
	style_that_box(quit_button)
	style_that_box(instructions_button)
	style_that_box(credits_button)
	style_that_box(high_score_button)

func _process(_delta: float) -> void:
	get_node("Hornet").position.y = (get_node("Hornet").position.y + bumble)
	get_node("Hornet/WingOption3").position += Vector2(-wing_bumble * .1,-wing_bumble * .2)
	get_node("Marker2D/Sprite2D/WingOption2").position += Vector2(-wing_bumble * .2,-wing_bumble * .2)
	if bumble_up:
		bumble -= .05
		if bumble <= -2:
			bumble_up = false
	else:
		bumble += .05
		if bumble >= 2:
			bumble_up = true
			
	if wing_bumble_up:
		wing_bumble -= .25
		if wing_bumble <= -3:
			wing_bumble_up = false
	else:
		wing_bumble += .25
		if wing_bumble >= 3:
			wing_bumble_up = true
	get_node("Marker2D").rotation -= 0.01
	
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func style_that_box(node_to_style : Node) -> void:
	var stylebox: StyleBox = node_to_style.get_theme_stylebox("normal")
	stylebox.bg_color = "#bbd200"
	node_to_style.add_theme_stylebox_override("normal", stylebox)
	node_to_style.show()


func _on_how_to_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/how_to_play.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_return_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_high_scores_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/high_scores.tscn")
