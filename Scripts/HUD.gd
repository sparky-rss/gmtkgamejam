extends CanvasLayer

func _ready() -> void:
	get_node("HBoxContainer/Level").text = str("Level: ", Globals.level)
	Globals.global_timer = get_node("GameTimer")
	Globals.global_timer.wait_time = 30 * Globals.level + 30
	Globals.global_timer.start()
	get_node("MenuBackground/VBoxContainer/MasterVolume").value = SoundManager.master_volume
	get_node("MenuBackground/VBoxContainer/MusicVolume").value = SoundManager.music_volume
	get_node("MenuBackground/VBoxContainer/SFXVolume").value = SoundManager.sfx_volume

func _process(_delta: float) -> void:
	get_node("HBoxContainer/FlowerCount").text = str("Flowers Left: ", Globals.unscored_flowers)
	get_node("HBoxContainer/TimeLeft").text = str("%0.0f" % get_node("GameTimer").time_left)
	if get_node("GameTimer").time_left <= 20.5:
		var red = Color(1.0,0.0,0.0,1.0)
		get_node("HBoxContainer/TimerLabel").set("theme_override_colors/font_color",red)
		get_node("HBoxContainer/TimeLeft").set("theme_override_colors/font_color",red)
	get_node("HBoxContainer/Score").text = str("Score: ", Globals.score)
	if Input.is_action_just_pressed("Escape Menu") and !get_node("MenuBackground").visible:
		get_node("MenuBackground").show()
		get_tree().paused = true
		var retry_node = get_node("MenuBackground/ResumeButton")
		var quit_node = get_node("MenuBackground/QuitButton")
		var menu_node = get_node("MenuBackground/MenuButton")
		style_that_box(retry_node)
		style_that_box(quit_node)
		style_that_box(menu_node)
	elif Input.is_action_just_pressed("Escape Menu") and get_node("MenuBackground").visible:
		get_node("MenuBackground").hide()
		get_tree().paused = false

func you_win() -> void:
	Globals.player.stop_sound("Collect")
	Globals.player.stop_sound("BGM")
	Globals.player.play_sound("YouWin")
	get_node("GameTimer").paused = true
	var you_win_node = get_node("YouWin")
	you_win_node.show()
	you_win_node.text = str("[font_size=50][rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]Level Complete![/wave][/rainbow][/font_size]")
	get_node("YouWin/Timer").start()

func you_lose(cause : String) -> void:
	Globals.player.stop_sound("BGM")
	Globals.player.play_sound("YouLose")
	get_node("GameTimer").paused = true
	var you_lose_node = get_node("YouLose")
	you_lose_node.show()
	if cause == "stung":
		you_lose_node.text = str("[font_size=50][wave amp=20 freq=20]Stung![/wave][/font_size]")
	elif cause == "timeout":
		you_lose_node.text = str("[font_size=50][wave amp=20 freq=20]Time's Up![/wave][/font_size]")
	get_node("YouLose/LossTimer").start()

func _on_timer_timeout() -> void:
	var time_taken_node = get_node("TimeTaken")
	time_taken_node.show()
	var bonus_score = int(get_node("GameTimer").time_left) * 10
	Globals.score += bonus_score
	time_taken_node.text = str("[font_size=50][rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]Time Remaining: ",str("%0.0f" % get_node("GameTimer").time_left),"\nBonus Score: ",bonus_score,"[/wave][/rainbow][/font_size]")
	get_node("TimeTaken/ButtonTimer").start()
	
func _on_button_timer_timeout() -> void:
	var next_level_node = get_node("NextLevelButton")
	style_that_box(next_level_node)

func _on_next_level_button_pressed() -> void:
	Globals.start_next_level()

func _on_loss_timer_timeout() -> void:
	var you_lose_node = get_node("YouLose")
	you_lose_node.text = str("[font_size=50]Game Over![/font_size]")
	var flowers_pollinated_node = get_node("FlowersPollinated")
	flowers_pollinated_node.show()
	flowers_pollinated_node.text = str("[font_size=50]Final Score: ", Globals.score, "[/font_size]")
	get_node("FlowersPollinated/RetryTimer").start()

func _on_retry_timer_timeout() -> void:
	var retry_node = get_node("RetryButton")
	style_that_box(retry_node)

func style_that_box(node_to_style : Node) -> void:
	var stylebox: StyleBox = node_to_style.get_theme_stylebox("normal")
	stylebox.bg_color = "#bbd200"
	node_to_style.add_theme_stylebox_override("normal", stylebox)
	node_to_style.show()
	

func _on_retry_button_pressed() -> void:
	Globals.show_high_scores()


func _on_master_volume_value_changed(value: float) -> void:
	SoundManager.set_master_volume(value)

func _on_music_volume_value_changed(value: float) -> void:
	SoundManager.set_music_volume(value)

func _on_sfx_volume_value_changed(value: float) -> void:
	SoundManager.set_sfx_volume(value)


func _on_resume_button_pressed() -> void:
	get_node("MenuBackground").hide()
	get_tree().paused = false


func _on_game_timer_timeout() -> void:
	Globals.game_over = true
	var HUD_node = get_parent().get_node("HUD")
	HUD_node.you_lose("timeout")
	Globals.player.get_node("Sprite2D").flip_v = true
	Globals.player.play_player_animation("dead", Globals.player.get_node("Sprite2D"))


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	Globals.return_to_menu()
