extends Node2D

@onready var button_press: AudioStreamPlayer2D = $ButtonPress
@onready var start_game_button_press: AudioStreamPlayer2D = $StartGameButtonPress
@onready var thud: AudioStreamPlayer2D = $Thud
@onready var u_isettingspop: AudioStreamPlayer2D = $UIsettingspop
@onready var drop_box_sound: AudioStreamPlayer2D = $DropBoxSound
@onready var player_moving_sound: AudioStreamPlayer2D = $PlayerMovingSound


func on_normal_button_pressed()->void:
	button_press.play()


func on_start_game_button_pressed()->void:
	start_game_button_press.play()


func on_game_over()->void:
	thud.play()


func on_settings_changed()->void:
	u_isettingspop.play()


func on_box_dropped()->void:
	drop_box_sound.play()


func on_player_moving()->void:
	player_moving_sound.play()
