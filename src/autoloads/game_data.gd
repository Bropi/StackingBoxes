extends Node

var score: int = 0
var high_score: int = 0


func update_score():
	score += 10
	if score > high_score:
		high_score = score


func save():
	var save = PlayerScore.new()
	save.high_score = high_score
	ResourceSaver.save(save, "user://save_data.tres")

func load():
	if FileAccess.file_exists("user://save_data.tres"):
		var save = ResourceLoader.load("user://save_data.tres")
		high_score = save.high_score
