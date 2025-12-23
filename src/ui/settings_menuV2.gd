extends Control


#Button names:
@onready var music_slider: HSlider = $MarginContainer2/HBoxContainer/AUDIO/VBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $MarginContainer2/HBoxContainer/AUDIO/VBoxContainer/SFXslider

@onready var resolution_option_button: OptionButton = $MarginContainer2/HBoxContainer/RESOLUTION/VBoxContainer/ResolutionOptionButton
@onready var v_sync_option_button: OptionButton = $"MarginContainer2/HBoxContainer/RESOLUTION/VBoxContainer/V-syncOptionButton"
@onready var window_option_button: OptionButton = $MarginContainer2/HBoxContainer/RESOLUTION/VBoxContainer/WindowOptionButton

@onready var key_rebind_button: Button = $MarginContainer2/HBoxContainer/KEYREBIND/VBoxContainer/KeyRebindButton

@onready var resolution_option_button_2: OptionButton = $MarginContainer2/HBoxContainer/RESOLUTION/VBoxContainer/ResolutionOptionButton2

var resolutions: Array[Vector2i] = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440)
]

var resolutions2: Dictionary = { 
	"1280x720": Vector2i(1280, 720),
	"1600x900": Vector2i(1600, 900),
	"1920x1080": Vector2i(1920, 1080),
	"2560x1440": Vector2i(2560, 1440)
}

var vsync_options: Dictionary = {
	"VSync Disabled": DisplayServer.VSYNC_DISABLED,
	"VSync Enabled": DisplayServer.VSYNC_ENABLED,
	"VSync Adaptive": DisplayServer.VSYNC_ADAPTIVE,
	"VSync Mailbox": DisplayServer.VSYNC_MAILBOX
}

var window_modes: Dictionary = {
	"Windowed": DisplayServer.WINDOW_MODE_WINDOWED,
	"Fullscreen": DisplayServer.WINDOW_MODE_FULLSCREEN,
	"Borderless": DisplayServer.WINDOW_MODE_MAXIMIZED 
}

func _ready() -> void:
	# Load saved values or set defaults of audio sliders
	var config = ConfigFile.new()
	var music_value := 0.7
	var sfx_value := 0.8
	
	if config.load("user://settings.cfg") == OK:
		music_value = config.get_value("audio", "music_volume", 0.7)
		sfx_value = config.get_value("audio", "sfx_volume", 0.8)

	# Apply to audio buses
	var music_bus = AudioServer.get_bus_index("Music")
	var sfx_bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(music_value))
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(sfx_value))

	# Sync sliders visually
	music_slider.value = music_value
	sfx_slider.value = sfx_value

	add_resolutions()
	add_v_sync_options()
	add_window_modes()


#region -- Handler funcs --

#old
#func _on_resolution_selected(index: int) -> void:
	#Sfx.on_settings_changed()
	#match index:
		#0:
			##DisplayServer.window_set_size(Vector2i(1280, 720))
			#get_window().set_size(resolutions[index])
		#1:
			##DisplayServer.window_set_size(Vector2i(1600, 900))
			#get_window().set_size(resolutions[index])
		#2:
			##DisplayServer.window_set_size(Vector2i(1920, 1080))
			#get_window().set_size(resolutions[index])
		#3:
			##DisplayServer.window_set_size(Vector2i(2560, 1440))
			#get_window().set_size(resolutions[index])


#old
#func _on_vsync_selected(index: int) -> void:
	#Sfx.on_settings_changed()
	#
	#var vsync_mode: int = DisplayServer.VSYNC_DISABLED
	#
	#match index:
		#0:
			#vsync_mode = DisplayServer.VSYNC_DISABLED
		#1:
			#vsync_mode = DisplayServer.VSYNC_ENABLED
		#2:
			#vsync_mode = DisplayServer.VSYNC_ADAPTIVE
		#3:
			#vsync_mode = DisplayServer.VSYNC_MAILBOX
	#
	#DisplayServer.window_set_vsync_mode(vsync_mode)
	#
	#print("vsync mode set to %s" % vsync_mode)
	


#audio
func _on_music_slider_value_changed(value: float) -> void:
	Sfx.on_settings_changed()
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_sf_xslider_value_changed(value: float) -> void:
	Sfx.on_settings_changed()
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_main_menu_button_pressed() -> void:
	Sfx.on_start_game_button_pressed()
	SceneSwitcher.switch_to_scene("res://src/ui/start_game_menu.tscn")


func add_resolutions() -> void:
	for r in resolutions2:
		resolution_option_button_2.add_item(r)


func add_v_sync_options() -> void:
	for v in vsync_options:
		v_sync_option_button.add_item(v)


func centre_window() -> void:
	var centre_screen = DisplayServer.screen_get_position()+DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_ime_position(centre_screen-window_size/2)


func _on_resolution_option_button_2_item_selected(index: int) -> void:
	Sfx.on_settings_changed()
	var ID = resolution_option_button_2.get_item_text(index)
	get_window().set_size(resolutions2[ID])
	centre_window()


func _on_vsync_option_button_item_selected(index: int) -> void:
	Sfx.on_settings_changed()
	
	var vsync_mode: int = DisplayServer.VSYNC_DISABLED
	
	match index:
		0:
			vsync_mode = DisplayServer.VSYNC_DISABLED
		1:
			vsync_mode = DisplayServer.VSYNC_ENABLED
		2:
			vsync_mode = DisplayServer.VSYNC_ADAPTIVE
		3:
			vsync_mode = DisplayServer.VSYNC_MAILBOX
	
	DisplayServer.window_set_vsync_mode(vsync_mode)
	

func add_window_modes() -> void:
	window_option_button.clear()
	for w in window_modes.keys():
		window_option_button.add_item(w)

func _on_window_option_button_item_selected(index: int) -> void:
	Sfx.on_settings_changed()
	
	var selected_name: String = window_option_button.get_item_text(index)
	
	if window_modes.has(selected_name):
		var window_mode: int = window_modes[selected_name]
		
		# Apply the corrected window mode constant
		DisplayServer.window_set_mode(window_mode)
		
		print("Window mode set to %s (Constant Value: %s)" % [selected_name, window_mode])
	else:
		print("Error: Window mode option not found: ", selected_name)
