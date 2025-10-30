extends Camera2D

@export var target : CharacterBody2D
@export var max_offset: float = 10.0
@export var shake_duration: float = 0.25 


var time_left: float = 0.0

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time_left > 0.0:
		#start shake
		time_left -= delta
		offset = Vector2(randf_range(-max_offset, max_offset), randf_range(-max_offset, max_offset))
		
		#Stop shake
		if time_left <= 0.0:
			offset = Vector2.ZERO


func _on_area_2d_body_entered(_body: Node2D) -> void:
	global_position.y -= 100
	target.global_position.y -= 100


func shake(duration: float = -1.0) -> void:
	time_left = duration if duration > 0.0 else shake_duration
	offset = Vector2.ZERO
