extends Node

var flower_scene : PackedScene = preload("res://Scenes/Flower.tscn")
var hornet_scene : PackedScene = preload("res://Scenes/hornet.tscn")
var unscored_flowers : int
var you_win : bool = false
var game_over : bool = false
var level : int = 1
var score : int = 0
var high_scores : Array = [10000, 5000, 2000, 1000, 500]
var high_score_names : Array = ["BEE", "FLY", "BUG", "ANT", "NIT"]
@export var player : Node
@export var global_timer : Node
@export var replacement_score : int = -1

func start_next_level() -> void:
	you_win = false
	level += 1
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func retry() -> void:
	game_over = false
	level = 1
	score = 0
	get_tree().change_scene_to_file("res://Scenes/high_scores.tscn")

func return_to_menu() -> void:
	game_over = false
	you_win = false
	level = 1
	score = 0
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func high_score_text() -> String:
	return str("[font_size=50][u]High Scores[/u]\n\n1: ",high_scores[0]," - ",high_score_names[0],"\n2: ",high_scores[1]," - ",high_score_names[1],"\n3: ",high_scores[2]," - ",high_score_names[2],"\n4: ",high_scores[3]," - ",high_score_names[3],"\n5: ",high_scores[4]," - ",high_score_names[4],"[/font_size]")

func new_high_score_text(input_letter : String = "") -> String:
	var name_string : String = high_score_names[replacement_score]
	if input_letter == "":
		return str("[font_size=50][u]High Scores[/u]\n[rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]New High Score![/wave][/rainbow]\n1: ",high_scores[0]," - ",high_score_names[0],"\n2: ",high_scores[1]," - ",high_score_names[1],"\n3: ",high_scores[2]," - ",high_score_names[2],"\n4: ",high_scores[3]," - ",high_score_names[3],"\n5: ",high_scores[4]," - ",high_score_names[4],"\n\nInput your initials; press Enter when done.[/font_size]")
	elif input_letter == "backspace":
		if name_string != "":
			name_string = name_string.erase(name_string.length()-1, 1)  
			high_score_names[replacement_score] = name_string
			return str("[font_size=50][u]High Scores[/u]\n[rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]New High Score![/wave][/rainbow]\n1: ",high_scores[0]," - ",high_score_names[0],"\n2: ",high_scores[1]," - ",high_score_names[1],"\n3: ",high_scores[2]," - ",high_score_names[2],"\n4: ",high_scores[3]," - ",high_score_names[3],"\n5: ",high_scores[4]," - ",high_score_names[4],"\n\nInput your initials; press Enter when done.[/font_size]")
		else:
			return str("[font_size=50][u]High Scores[/u]\n[rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]New High Score![/wave][/rainbow]\n1: ",high_scores[0]," - ",high_score_names[0],"\n2: ",high_scores[1]," - ",high_score_names[1],"\n3: ",high_scores[2]," - ",high_score_names[2],"\n4: ",high_scores[3]," - ",high_score_names[3],"\n5: ",high_scores[4]," - ",high_score_names[4],"\n\nInput your initials; press Enter when done.[/font_size]")
	else:
		if name_string.length() < 3:
			name_string += input_letter
			high_score_names[replacement_score] = name_string
			return str("[font_size=50][u]High Scores[/u]\n[rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]New High Score![/wave][/rainbow]\n1: ",high_scores[0]," - ",high_score_names[0],"\n2: ",high_scores[1]," - ",high_score_names[1],"\n3: ",high_scores[2]," - ",high_score_names[2],"\n4: ",high_scores[3]," - ",high_score_names[3],"\n5: ",high_scores[4]," - ",high_score_names[4],"\n\nInput your initials; press Enter when done.[/font_size]")
		else:
			return str("[font_size=50][u]High Scores[/u]\n[rainbow freq=.2 sat=.8 val=.8][wave amp=20 freq=20]New High Score![/wave][/rainbow]\n1: ",high_scores[0]," - ",high_score_names[0],"\n2: ",high_scores[1]," - ",high_score_names[1],"\n3: ",high_scores[2]," - ",high_score_names[2],"\n4: ",high_scores[3]," - ",high_score_names[3],"\n5: ",high_scores[4]," - ",high_score_names[4],"\n\nInput your initials; press Enter when done.[/font_size]")
		
func show_high_scores():
	var temp_score : int
	var temp_name_1 : String
	var temp_name_2 : String
	for i in high_scores.size():
		if score >= high_scores[i]:
			if replacement_score == -1:
				replacement_score = i
				temp_score = high_scores[i]
				high_scores[i] = score
				score = temp_score
				temp_name_1 = high_score_names[i]
				high_score_names[i] = ""
			else:
				temp_score = high_scores[i]
				high_scores[i] = score
				score = temp_score
				temp_name_2 = high_score_names[i]
				high_score_names[i] = temp_name_1
				temp_name_1 = temp_name_2
	retry()
			
