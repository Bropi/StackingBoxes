extends Control


func _on_start_game_button_pressed() -> void:
	Sfx.on_start_game_button_pressed()
	SceneSwitcher.switch_to_scene("res://src/levels/level.tscn")


func _on_settings_button_pressed() -> void:
	Sfx.on_normal_button_pressed()
	SceneSwitcher.switch_to_scene("res://src/ui/settings_menu.tscn")


func _on_quit_game_button_pressed() -> void:
	Sfx.on_normal_button_pressed()
	get_tree().quit()
