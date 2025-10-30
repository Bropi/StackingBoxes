extends Node

var current_scene: Node = null

func _ready():
	current_scene = get_tree().current_scene

func switch_to_scene(path):
	print("new scene!")
	get_tree().change_scene_to_file(path)
