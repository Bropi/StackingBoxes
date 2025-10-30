extends Node2D


#this function is triggered by a signal in mainV2.gd
func _on_level_reload_scene() -> void:
	get_tree().reload_current_scene()
