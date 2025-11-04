extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 500.0
const BOXV2 = preload("res://src/characters/player/weapons/box_v2/box_v_2.tscn")

var can_spawn : bool = true  # true = next press will spawn
var has_box : bool = false
var is_moving : bool = false
var has_started_moving : bool = false
var box_instance: Node2D



func _ready() -> void:
	call_deferred("set_tweens")


func _physics_process(_delta: float) -> void:
	# Handle movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		is_moving = true
		on_player_moving()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		is_moving = false
		has_started_moving = false
		Sfx.player_moving_sound.stop()

	# Handle drop box input
	if Input.is_action_just_pressed("drop_box"):
		if can_spawn:
			spawn_box()
			has_box = true
			can_spawn = false
		else:
			can_spawn = true

	move_and_slide()


func spawn_box() -> void:
	box_instance = BOXV2.instantiate()
	Sfx.on_normal_button_pressed()
	var current_scene_root = get_tree().current_scene
	if current_scene_root != null:
		current_scene_root.add_child(box_instance)
	else:
		get_tree().root.add_child(box_instance)
		
	box_instance.global_position = self.global_position + Vector2(0, 75)
	print("Box dropped!")

func on_player_moving() -> void:
	if is_moving:
		if !has_started_moving:
			#print("player moving!")
			Sfx.on_player_moving()
			has_started_moving = true
	else:
		return


func set_tweens() -> void:
	var start_y = sprite_2d.position.y
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(sprite_2d, "position:y", start_y - 10, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite_2d, "position:y", start_y, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
