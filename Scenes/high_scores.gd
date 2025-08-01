extends CanvasLayer

var bumble_up : bool = true
var wing_bumble_up : bool = true
var bumble : float = 0
var wing_bumble : float = 0
var high_score_input : bool = false

func _ready() -> void:
	var return_button = get_node("ReturnToMenu")
	var quit_button = get_node("Quit")
	style_that_box(return_button)
	style_that_box(quit_button)
	if Globals.replacement_score != -1:
		input_high_score()
		return_button.hide()
		quit_button.hide()
	else:
		get_node("MenuBackground/Label").text = Globals.high_score_text()

func input_high_score():
	get_node("MenuBackground/Label").text = Globals.new_high_score_text()
	high_score_input = true
	#TODO: add initials

func _process(_delta: float) -> void:
	
	if high_score_input:
		if Input.is_key_pressed(KEY_0) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("0")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_1) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("1")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_2) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("2")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_3) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("3")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_4) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("4")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_5) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("5")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_6) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("6")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_7) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("7")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_8) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("8")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_9) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("9")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_A) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("A")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_B) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("B")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_C) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("C")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_D) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("D")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_E) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("E")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_F) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("F")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_G) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("G")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_H) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("H")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_I) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("I")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_J) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("J")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_K) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("K")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_L) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("L")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_M) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("M")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_N) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("N")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_O) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("O")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_P) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("P")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_Q) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("Q")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_R) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("R")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_S) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("S")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_T) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("T")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_U) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("U")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_V) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("V")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_W) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("W")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_X) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("X")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_Y) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("Y")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_Z) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("Z")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_BACKSPACE) and get_node("DebounceTimer").time_left == 0:
			get_node("MenuBackground/Label").text = Globals.new_high_score_text("backspace")
			get_node("DebounceTimer").start()
		if Input.is_key_pressed(KEY_ENTER):
			get_node("MenuBackground/Label").text = Globals.high_score_text()
			Globals.replacement_score = -1
			high_score_input = false
			var return_button = get_node("ReturnToMenu")
			var quit_button = get_node("Quit")
			return_button.show()
			quit_button.show()
			
	
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
