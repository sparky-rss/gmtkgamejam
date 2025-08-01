extends Resource
class_name PlayerData

@export var high_scores : Array
@export var high_score_names : Array

func save():
	high_scores = Globals.high_scores
	high_score_names = Globals.high_score_names
	#print(str("Save Data:"))
	#print(str("High Scores: ",high_scores))
	#print(str("High Score Initials: ",high_score_names))

func load():
	Globals.high_scores = high_scores
	Globals.high_score_names = high_score_names
	#print(str("Load Data:"))
	#print(str("High Scores: ",high_scores))
	#print(str("High Score Initials: ",high_score_names))
