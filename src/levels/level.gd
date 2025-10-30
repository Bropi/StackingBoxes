extends Node2D

signal reload_scene

@onready var hitmarker: ColorRect = $CanvasLayer/Hitmarker
@onready var camera_2d: Camera2D = $Camera2D
@onready var score_label: Label = $CanvasLayer/ScoreLabel

var scene_reloading: bool = false

func _ready() -> void:
	#load saved high score
	if FileAccess.file_exists("user://save_data.tres"):
		var save = ResourceLoader.load("user://save_data.tres")
		GameData.high_score = save.high_score
	
	score_label.text = "Score: %d\nHigh Score: %d" % [GameData.score, GameData.high_score]

# reload the scene after a box has been dropped on the ground
func _on_area_2d_body_entered(_body: Node2D) -> void:
	# Shake camera, flash the screen red
	camera_2d.shake(0.4) # Start 0.4 seconden schudden
	hitmarker.visible = true
	await get_tree().create_timer(0.1).timeout
	hitmarker.visible = false
	
	
	if not scene_reloading:
		await get_tree().create_timer(2.0).timeout
		restart_scene()

func restart_scene() -> void:
	scene_reloading = true
	print("scene restart (level.gd)")
	#wait 2 seconds and emit a signal to main and children that they need to be reset
	
	emit_signal("reload_scene")
	MainV2._on_level_reload_scene()
	scene_reloading = false
	GameData.score = 0
	GameData.save()

func _on_camera_2d_camera_limit() -> void:
	score_label.text = "Score: %d\nHigh Score: %d" % [GameData.score, GameData.high_score]
	print("+10 score!")
