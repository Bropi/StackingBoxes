class_name Main extends Node

@export var world_2d : Node2D
@export var gui : Control

var current_world2d_scene = world_2d
var current_gui_scene = gui


func _ready() -> void:
	#Global.game_controller = self
	change_world2d_scene("res://src/levels/level.tscn")


func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free() # Removes scene node entirely
		elif keep_running:
			current_gui_scene.visible = false #Keeps scene node in memory and running
		else:
			gui.remove_child(current_gui_scene) #Keeps scene node in memory, does not run
	var new_gui_scene = load(new_scene).instantiate()
	gui.add_child(new_gui_scene)
	current_gui_scene = new_gui_scene



func change_world2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_world2d_scene != null:
		if delete:
			current_world2d_scene.queue_free() # Removes scene node entirely
		elif keep_running:
			current_world2d_scene.visible = false #Keeps scene node in memory and running
		else:
			gui.remove_child(current_world2d_scene) #Keeps scene node in memory, does not run
	var new_world_scene = load(new_scene).instantiate()
	world_2d.add_child(new_world_scene)
	current_world2d_scene = new_world_scene
