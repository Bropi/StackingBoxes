extends Control


#Button names:
@onready var music_slider: HSlider = $MarginContainer2/HBoxContainer/AUDIO/VBoxContainer/MusicSlider
@onready var sf_xslider: HSlider = $MarginContainer2/HBoxContainer/AUDIO/VBoxContainer/SFXslider

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
	# --- Fill Resolution options ---
	for res in resolutions:
		resolution_option_button.add_item("%dx%d" % [res.x, res.y])

	# --- Fill V-Sync options ---
	v_sync_option_button.add_item("Off")
	v_sync_option_button.add_item("On")

	# --- Fill Window Mode options ---
	window_option_button.add_item("Windowed")
	window_option_button.add_item("Borderless")
	window_option_button.add_item("Fullscreen")

	# --- Connect signals ---
	resolution_option_button.item_selected.connect(_on_resolution_selected)
	v_sync_option_button.item_selected.connect(_on_vsync_selected)
	window_option_button.item_selected.connect(_on_window_selected)


# --- Handlers ---

func _on_resolution_selected(index: int) -> void:
	Sfx.on_settings_changed()
	var res := resolutions[index]
	DisplayServer.window_set_size(res)


func _on_vsync_selected(index: int) -> void:
	Sfx.on_settings_changed()
	match index:
		0:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		1:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)


func _on_window_selected(index: int) -> void:
	Sfx.on_settings_changed()
	match index:
		0: # Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: # Borderless
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		2: # Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)



func _on_main_menu_button_pressed() -> void:
	Sfx.on_start_game_button_pressed()
	SceneSwitcher.switch_to_scene("res://src/ui/start_game_menu.tscn")
