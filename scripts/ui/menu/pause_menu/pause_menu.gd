class_name PauseMenu
extends AbstractMenu


var is_opened: bool = false

var _current_open_popup: AbstractMenu = null

@export_group("Connections")
@export var _menu: CenterContainer
@export var _manual_menu: TrainingScreen
@export var _settings_menu: SettingsMenu
@export var _animation_background: AnimationPlayer


func _ready() -> void:
	Settings.audio_settings.play_music_on_pause.setting_changed.connect(_on_setting_play_music_on_pause_changed)
	_settings_menu.close_menu()
	close_menu()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_menu"):
		if _current_open_popup == null:
			(close_menu if get_tree().paused else open_menu).call()
		else:
			_current_open_popup.close_menu()


func open_menu() -> void:
	show()
	_display(true)
	_animation_background.play("show")


func close_menu() -> void:
	_display(false)
	_animation_background.play_backwards("show")
	await _animation_background.animation_finished
	hide()


func _display(is_open: bool) -> void:
	is_opened = is_open
	_menu.visible = is_open
	get_tree().paused = is_open
	(_animation_background.play if is_open else _animation_background.play_backwards).call("show")
	_music_mute(is_open and not Settings.audio_settings.play_music_on_pause.is_on)


func _music_mute(enable: bool) -> void:
	var bus_index: int = AudioServer.get_bus_index(GlobalParameters.MUSIC_AUDIO_BUS)
	AudioServer.set_bus_mute(bus_index, enable)


func _open_popup_menu(popup_menu: AbstractMenu) -> void:
	_menu.hide()
	popup_menu.open_menu()
	_current_open_popup = popup_menu


func _on_popup_menu_closed() -> void:
	_menu.show()
	_current_open_popup = null


func _on_setting_play_music_on_pause_changed(new_value: bool) -> void:
	_music_mute(not new_value)


func _on_resume_button_pressed() -> void: close_menu()

func _on_restart_button_pressed() -> void: get_tree().reload_current_scene()

func _on_manual_button_pressed() -> void: _open_popup_menu(_manual_menu)

func _on_settings_button_pressed() -> void: _open_popup_menu(_settings_menu)

func _on_leave_button_pressed() -> void:
	get_tree().paused = false
	GlobalParameters.change_scene("res://scenes/ui/menu/main_menu/main_menu.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	GlobalParameters.exit_game()
