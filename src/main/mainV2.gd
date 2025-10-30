extends Node2D

func _ready() -> void:
	call_deferred("start_game")

#this function is triggered by a global call in level.gd
func _on_level_reload_scene() -> void:
	#get_tree().reload_current_scene()
	print("main.gd: level reloading")
	SceneSwitcher.switch_to_scene("res://src/ui/start_game_menu.tscn")

func start_game():
	#switches to level scene
	SceneSwitcher.switch_to_scene("res://src/ui/start_game_menu.tscn")
