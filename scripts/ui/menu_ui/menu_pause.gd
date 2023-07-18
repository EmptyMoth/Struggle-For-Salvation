extends Control


var just_closed: bool = false

@onready var menu_pause: CenterContainer = $Margins/MenuPause
@onready var settings_menu: Control = $Margins/SettingsMenu


func _ready() -> void:
	Settings.audio_settings.play_music_on_pause.setting_changed.connect(
			_on_play_music_on_pause_changed)
	settings_menu.hide()
	menu_pause.show()


func pause_game() -> void:
	show()
	get_tree().paused = true
	if not Settings.audio_settings.play_music_on_pause.is_on:
		_music_mute(true)


func close_menu() -> void:
	hide()
	get_tree().paused = false
	just_closed = true
	_music_mute(false)


func _music_mute(enable: bool) -> void:
	var bus_index: int = AudioServer.get_bus_index(GlobalParameters.MUSIC_AUDIO_BUS)
	AudioServer.set_bus_mute(bus_index, enable)


func _on_play_music_on_pause_changed(new_value: bool) -> void:
	_music_mute(not new_value)


func _on_button_continue_pressed() -> void:
	close_menu()


func _on_button_manual_pressed():
	pass # Replace with function body.


func _on_button_settings_pressed() -> void:
	settings_menu.show()
	menu_pause.hide()


func _on_settings_menu_menu_exited() -> void:
	menu_pause.show()
	settings_menu.hide()


func _on_button_level_select_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/menu_ui/level_select/menu_level_select.tscn")


func _on_button_main_menu_pressed() -> void:
	get_tree().paused = false
	@warning_ignore("return_value_discarded")
	get_tree().change_scene_to_file("res://scenes/ui/menu_ui/main_menu.tscn")


func _on_button_exit_pressed() -> void:
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
