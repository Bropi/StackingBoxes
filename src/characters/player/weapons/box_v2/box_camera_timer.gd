extends RigidBody2D

var is_dropping: bool = false
var target_name: String = "Player"
var target_node: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set a timer and add collision layer 3 with a bitwise operation for camera detection
	#self.freeze = true
	gravity_scale = 0
	is_dropping = true
	#add a target to follow - this doesnt work for now.
	#target_node = get_node_or_null("level/Player")
	#if target_node == null:
		#print("Target not found!")


func _physics_process(_delta: float) -> void:
	if target_node == null:
		target_node = get_node_or_null("level/Player")
	
	if target_node:
		global_position = target_node.global_position
		global_position.y += 75
	
	if Input.is_action_just_pressed("drop_box"):
		is_dropping = false
		#self.freeze = false
		gravity_scale = 1
		await get_tree().create_timer(1.0).timeout
		self.collision_layer |= 4
