extends Control


#Button names:
@onready var music_slider: HSlider = $MarginContainer2/HBoxContainer/AUDIO/VBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $MarginContainer2/HBoxContainer/AUDIO/VBoxContainer/SFXslider

@onready var resolution_option_button: OptionButton = $MarginContainer2/HBoxContainer/RESOLUTION/VBoxContainer/ResolutionOptionButton
@onready var v_sync_option_button: OptionButton = $"MarginContainer2/HBoxContainer/RESOLUTION/VBoxContainer/V-syncOptionButton"
@onready var window_option_button: OptionButton = $MarginContainer2/HBoxContainer/RESOLUTION/VBoxContainer/WindowOptionButton

@onready var key_rebind_button: Button = $MarginContainer2/HBoxContainer/KEYREBIND/VBoxContainer/KeyRebindButton


var resolutions: Array[Vector2i] = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440)
]


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



# --- Handlers ---

func _on_resolution_selected(index: int) -> void:
	Sfx.on_settings_changed()
	


func _on_vsync_selected(index: int) -> void:
	Sfx.on_settings_changed()
	


func _on_window_selected(index: int) -> void:
	Sfx.on_settings_changed()
	

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
