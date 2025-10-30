extends CharacterBody2D

const SPEED = 500.0
const BOXV2 = preload("res://src/characters/player/weapons/box_v2/box_v_2.tscn")

var can_spawn := true  # true = next press will spawn
var box_instance: Node2D

func _physics_process(_delta: float) -> void:
	# Handle movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle drop box input
	if Input.is_action_just_pressed("drop_box"):
		if can_spawn:
			spawn_box()
			can_spawn = false
		else:
			can_spawn = true

	move_and_slide()


func spawn_box() -> void:
	box_instance = BOXV2.instantiate()
	
	var current_scene_root = get_tree().current_scene
	if current_scene_root != null:
		current_scene_root.add_child(box_instance)
	else:
		get_tree().root.add_child(box_instance)
		
	box_instance.global_position = self.global_position + Vector2(0, 75)
	print("Box dropped!")
