class_name PauseMenu
extends Control


const _DROP_DURATION: float = 0.3

var is_opened: bool = false

@onready var _menu: CenterContainer = $Menu
@onready var _manual_menu: TrainingScreen = $TrainingScreen
@onready var _settings_menu: SettingsMenu = $SettingsMenu
@onready var _buttons_container: MovingContainer = $Menu/Moving
@onready var _animation_background: AnimationPlayer = $Background/Animation


func _ready() -> void:
	Settings.audio_settings.play_music_on_pause.setting_changed.connect(
		_on_setting_play_music_on_pause_changed)
	_settings_menu.close_menu()
	close_menu()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_menu"):
		(close_menu if is_opened else open_menu).call()


func open_menu() -> void:
	is_opened = true
	show()
	_display(is_opened)
	get_tree().paused = is_opened
	if not Settings.audio_settings.play_music_on_pause.is_on:
		_music_mute(true)


func close_menu() -> void:
	is_opened = false
	_display(is_opened)
	get_tree().paused = is_opened
	_music_mute(false)


func _music_mute(enable: bool) -> void:
	var bus_index: int = AudioServer.get_bus_index(GlobalParameters.MUSIC_AUDIO_BUS)
	AudioServer.set_bus_mute(bus_index, enable)


func _display(is_displayed: bool) -> void:
	(_animation_background.play if is_displayed else _animation_background.play_backwards).call("show")
	var tween: Tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel()
	var to: float = 0.0 \
			if is_displayed \
			else -(10.0 + _buttons_container.get_child(0).size.y + get_viewport_rect().get_center().y)
	_buttons_container.move_container_from_current(tween, SIDE_TOP, to, _DROP_DURATION)


func _on_setting_play_music_on_pause_changed(new_value: bool) -> void:
	_music_mute(not new_value)


func _on_resume_button_pressed() -> void: close_menu()


func _on_restart_button_pressed() -> void: get_tree().reload_current_scene()


func _on_manual_button_pressed() -> void:
	_menu.hide()
	_manual_menu.open_training()


func _on_manual_menu_closed() -> void:
	_menu.show()


func _on_settings_button_pressed() -> void:
	_menu.hide()
	_settings_menu.open_menu()


func _on_settings_menu_closed() -> void:
	_menu.show()


func _on_leave_button_pressed() -> void:
	get_tree().paused = false


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	GlobalParameters.exit_game()


func _on_animation_animation_finished(_anim_name: StringName) -> void:
	visible = is_opened
