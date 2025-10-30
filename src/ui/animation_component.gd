class_name AnimationComponent extends Node

@export var from_center : bool = true
@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var time : float = 0.1
@export var transition_type : Tween.TransitionType

var target : Control
var default_scale : Vector2


func _ready() -> void:
	target = get_parent()
	
	#wait for every child node to be setup
	call_deferred("setup")
	call_deferred("connect_input")


#mandatory for detecting the target button control node and connect it to the on- & off_hover functions
func connect_input() -> void:
	target.mouse_entered.connect(on_hover)
	target.mouse_exited.connect(off_hover)



func setup() -> void:
	if from_center:
		target.pivot_offset = target.size / 2 
	default_scale = target.scale

func on_hover() -> void:
	add_tween("scale", hover_scale, time)

func off_hover() -> void:
	add_tween("scale", default_scale, time)

func add_tween(property: String, value, seconds: float) -> void:
	if !is_inside_tree() or get_tree() == null:
		return
	var tween = get_tree().create_tween()
	tween.tween_property(target, property, value, seconds).set_trans(transition_type)
