extends Control



func _on_main_menu_button_pressed() -> void:
	SceneSwitcher.switch_to_scene("res://src/ui/start_game_menu.tscn")


func _on_quit_game_button_pressed() -> void:
	get_tree().quit()
