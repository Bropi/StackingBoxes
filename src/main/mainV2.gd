extends Node2D

func _ready() -> void:
	start_game()

#this function is triggered by a signal in mainV2.gd
func _on_level_reload_scene() -> void:
	get_tree().reload_current_scene()

func start_game():
	#switches to level scene
	SceneSwitcher.switch_to_scene("res://src/levels/level.tscn")
