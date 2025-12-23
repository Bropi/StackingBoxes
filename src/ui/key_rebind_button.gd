extends Button
class_name InputRebindButton

@export var action_to_remap: String = "move_left"
@export var status_label_path: NodePath 


var is_remapping: bool = false
var status_label: Label = null
signal input_received(event) 


func _ready() -> void:
	pressed.connect(_on_input_rebind_button_pressed)
	
	if status_label_path:
		status_label = get_node(status_label_path)
	
	if status_label:
		status_label.text = "Click to set input for '%s'." % action_to_remap
	
	update_button_text()


func _input(event: InputEvent) -> void:
	if is_remapping:
		if event.is_pressed():
			if event is InputEventKey or event is InputEventMouseButton:
				get_viewport().set_input_as_handled() 
				input_received.emit(event)


func await_single_input() -> InputEvent:
	var event = await input_received 
	return event


func update_button_text() -> void:
	var events: Array[InputEvent] = InputMap.action_get_events(action_to_remap)
	
	var key_event: InputEvent = null
	for event in events:
		if event is InputEventKey or event is InputEventMouseButton:
			key_event = event
			break
			
	if key_event:
		text = key_event.as_text().to_upper()
	else:
		text = "Unbound"

func update_status(message: String) -> void:
	if status_label:
		status_label.text = message


func _on_input_rebind_button_pressed() -> void:
	if is_remapping:
		return
	
	if action_to_remap.is_empty():
		update_status("Error: Action name is not set.")
		return
	
	is_remapping = true
	disabled = true
	
	update_status("Press the NEW key for '%s'..." % action_to_remap)
	var new_event: InputEvent = await await_single_input()
	
	if new_event is InputEventKey or new_event is InputEventMouseButton:
		
		var existing_events: Array = InputMap.action_get_events(action_to_remap)
		for event in existing_events:
			InputMap.action_erase_event(action_to_remap, event)
		
		InputMap.action_add_event(action_to_remap, new_event)
		
		update_status("'%s' is now mapped to %s." % [action_to_remap, new_event.as_text().to_upper()])
		update_button_text()
		
		
	else:
		update_status("Assignment failed: Invalid input selected.")
		
	disabled = false
	is_remapping = false
