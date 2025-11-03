extends Control


func _on_resume_game_button_pressed() -> void:
	Sfx.on_start_game_button_pressed()
	get_tree().paused = false
	visible = false


func _on_main_menu_button_pressed() -> void:
	Sfx.on_normal_button_pressed()
	get_tree().paused = false
	visible = false
	SceneSwitcher.switch_to_scene("res://src/ui/start_game_menu.tscn")



func _on_settings_button_pressed() -> void:
	Sfx.on_normal_button_pressed()
	SceneSwitcher.switch_to_scene("res://src/ui/settings_menu.tscn")


func _on_quit_game_button_pressed() -> void:
	Sfx.on_normal_button_pressed()
	get_tree().quit()
	
