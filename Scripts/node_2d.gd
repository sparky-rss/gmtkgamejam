extends CanvasLayer

var bumble_up : bool = true
var bumble : float = 0
var looping : bool = false
var loop_center : Vector2 = Vector2.ZERO
var loop_angle : float = 0.0
var loop_direction : int = 1
var loop_steps : int = 50
var loop_step : int = 0
var start_offset : Vector2 = Vector2.ZERO
var loop_duration : float = 1.0
var incoming_velocity : float = 0.0
var exit_velocity : float

func _ready() -> void:
	SoundManager.init_sound_system()
	var title_node = get_node("MenuBackground/Label")
	title_node.text = str("[font_size=50][rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]Loop-Bee-Loop[/wave][/rainbow][/font_size]")
	var start_button = get_node("StartGame")
	var quit_button = get_node("Quit")
	style_that_box(start_button)
	style_that_box(quit_button)

func _process(_delta: float) -> void:
	get_node("Hornet").position.y = (get_node("Hornet").position.y + bumble)
	if bumble_up:
		bumble -= .05
		if bumble <= -2:
			bumble_up = false
	else:
		bumble += .05
		if bumble >= 2:
			bumble_up = true
	
	#TODO: Get bee to do loop-de-loops!
	
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func style_that_box(node_to_style : Node) -> void:
	var stylebox: StyleBox = node_to_style.get_theme_stylebox("normal")
	stylebox.bg_color = "#bbd200"
	node_to_style.add_theme_stylebox_override("normal", stylebox)
	node_to_style.show()
