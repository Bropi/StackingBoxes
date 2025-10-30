extends Node2D

@onready var box_instance: Node2D = $BoxInstance

const BOX_SCENES = {
	"circle": preload("res://src/characters/player/weapons/box_v2/circle_box.tscn"),
	"triangle": preload("res://src/characters/player/weapons/box_v2/triangle_box.tscn"),
	"square": preload("res://src/characters/player/weapons/box_v2/square_box.tscn"),
	"long_vertical": preload("res://src/characters/player/weapons/box_v2/long_box_vertical.tscn"),
	"long_horizontal": preload("res://src/characters/player/weapons/box_v2/long_box_horizontal.tscn"),
}

#var box_scene
var rng = RandomNumberGenerator.new()
var box_type = ["circle", "triangle", "square", "long_vertical", "long_horizontal"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	
	#Randomly select the string key of the box type dictionary
	var random_index = rng.randi_range(0, box_type.size() - 1) #variable dictionary size + no edge cases
	var random_key = box_type[random_index]
	
	#Look up scene using the random key and instantiate it & add it to scene
	box_instance = BOX_SCENES[random_key].instantiate()
	add_child(box_instance)
	box_instance.global_position = self.global_position
	#box_instance = box_scene
	
	##set a timer and add collision layer 3 with a bitwise operation for camera detection
	#await get_tree().create_timer(1.0).timeout
	#global_position = box_instance.global_position
	#collision_area.collision_layer |= 4
