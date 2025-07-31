extends CanvasLayer

func _ready() -> void:
	get_node("Level").text = str("Level: ", Globals.level)
	Globals.global_timer = get_node("GameTimer")
	get_node("MenuBackground/VBoxContainer/MasterVolume").value = SoundManager.master_volume
	get_node("MenuBackground/VBoxContainer/MusicVolume").value = SoundManager.music_volume
	get_node("MenuBackground/VBoxContainer/SFXVolume").value = SoundManager.sfx_volume

func _process(_delta: float) -> void:
	get_node("FlowerCount").text = str("Flowers Left: ", Globals.unscored_flowers)
	get_node("TimeLeft").text = str("%0.0f" % get_node("GameTimer").time_left)
	if Input.is_action_just_pressed("Escape Menu") and !get_node("MenuBackground").visible:
		get_node("MenuBackground").show()
		get_tree().paused = true
		var retry_node = get_node("MenuBackground/ResumeButton")
		var quit_node = get_node("MenuBackground/QuitButton")
		style_that_box(retry_node)
		style_that_box(quit_node)
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
	you_win_node.text = str("[font_size=50][rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]You Win![/wave][/rainbow][/font_size]")
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
	time_taken_node.text = str("[font_size=50][rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]Time Remaining: ",str("%0.0f" % get_node("GameTimer").time_left),"[/wave][/rainbow][/font_size]")
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
	flowers_pollinated_node.text = str("[font_size=50]Flowers Pollinated: ",Globals.level * 100 - Globals.unscored_flowers,"[/font_size]")
	get_node("FlowersPollinated/RetryTimer").start()

func _on_retry_timer_timeout() -> void:
	var retry_node = get_node("RetryButton")
	var quit_node = get_node("QuitButton")
	style_that_box(retry_node)
	style_that_box(quit_node)

func style_that_box(node_to_style : Node) -> void:
	var stylebox: StyleBox = node_to_style.get_theme_stylebox("normal")
	stylebox.bg_color = "#bbd200"
	node_to_style.add_theme_stylebox_override("normal", stylebox)
	node_to_style.show()
	

func _on_retry_button_pressed() -> void:
	Globals.retry()

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_master_volume_value_changed(value: float) -> void:
	SoundManager.set_master_volume(value)

func _on_music_volume_value_changed(value: float) -> void:
	SoundManager.set_music_volume(value)

func _on_sfx_volume_value_changed(value: float) -> void:
	SoundManager.set_sfx_volume(value)


func _on_resume_button_pressed() -> void:
	get_node("MenuBackground").hide()
	get_tree().paused = false
