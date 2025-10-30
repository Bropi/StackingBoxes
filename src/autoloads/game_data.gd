extends Node

var score: int = 0
var high_score: int = 0


func update_score():
	score += 10
	if score > high_score:
		high_score = score


func save():
	var save_new = PlayerScore.new()
	save_new.high_score = high_score
	ResourceSaver.save(save_new, "user://save_data.tres")

func load():
	if FileAccess.file_exists("user://save_data.tres"):
		var save_new = ResourceLoader.load("user://save_data.tres")
		high_score = save_new.high_score
