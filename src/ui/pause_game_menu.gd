extends Control


func _on_resume_game_button_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	SceneSwitcher.switch_to_scene("res://src/ui/start_game_menu.tscn")



func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_game_button_pressed() -> void:
	get_tree().quit()
	
