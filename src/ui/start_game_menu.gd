extends Control



func _on_start_game_button_pressed() -> void:
	SceneSwitcher.switch_to_scene("res://src/levels/level.tscn")


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_game_button_pressed() -> void:
	get_tree().quit()
