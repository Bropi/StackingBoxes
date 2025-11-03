extends Control


func _on_main_menu_button_pressed() -> void:
	Sfx.on_start_game_button_pressed()
	SceneSwitcher.switch_to_scene("res://src/ui/start_game_menu.tscn")


func _on_quit_game_button_pressed() -> void:
	Sfx.on_normal_button_pressed()
	get_tree().quit()
