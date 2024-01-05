class_name PauseMenu
extends Control


var is_opened: bool = false

@onready var menu: CenterContainer = $Menu
@onready var settings_menu: SettingsMenu = $SettingsMenu


func _ready() -> void:
	Settings.audio_settings.play_music_on_pause.setting_changed.connect(
		_on_setting_play_music_on_pause_changed)
	settings_menu.menu_closed.connect(_on_settings_menu_closed)
	settings_menu.close_menu()
	close_menu()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_menu"):
		if is_opened:
			close_menu()
		else:
			open_menu()


func open_menu() -> void:
	show()
	is_opened = true
	get_tree().paused = true
	if not Settings.audio_settings.play_music_on_pause.is_on:
		_music_mute(true)


func close_menu() -> void:
	hide()
	is_opened = false
	get_tree().paused = false
	_music_mute(false)


func _music_mute(enable: bool) -> void:
	var bus_index: int = AudioServer.get_bus_index(GlobalParameters.MUSIC_AUDIO_BUS)
	AudioServer.set_bus_mute(bus_index, enable)


func _on_setting_play_music_on_pause_changed(new_value: bool) -> void:
	_music_mute(not new_value)


func _on_button_exit_pressed() -> void:
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_resume_button_pressed() -> void: close_menu()


func _on_restart_button_pressed() -> void: get_tree().reload_current_scene()


func _on_manual_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	settings_menu.open_menu()
	menu.hide()


func _on_settings_menu_closed() -> void:
	settings_menu.close_menu()
	menu.show()


func _on_leave_button_pressed() -> void:
	get_tree().paused = false
	SceneTransition.change_scene_to_file("res://scenes/ui/menu/main_menu.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	GlobalParameters.exit_game()
