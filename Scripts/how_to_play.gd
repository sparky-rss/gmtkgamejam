extends CanvasLayer

var bumble_up : bool = true
var wing_bumble_up : bool = true
var bumble : float = 0
var wing_bumble : float = 0

func _ready() -> void:
	var return_button = get_node("ReturnToMenu")
	var quit_button = get_node("Quit")
	style_that_box(return_button)
	style_that_box(quit_button)

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

func style_that_box(node_to_style : Node) -> void:
	var stylebox: StyleBox = node_to_style.get_theme_stylebox("normal")
	stylebox.bg_color = "#bbd200"
	node_to_style.add_theme_stylebox_override("normal", stylebox)
	node_to_style.show()

func _on_return_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
