extends Node

var score: int = 0
var high_score: int = 0


func update_score():
	score += 10
	if score > high_score:
		high_score = score
