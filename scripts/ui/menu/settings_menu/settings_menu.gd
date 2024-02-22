class_name SettingsMenu
extends Control


signal menu_closed

const _DROP_DURATION: float = 0.5

@onready var settings: TabContainer = $CenterContainer/VBoxContainer/MainMoving/Panel/Margin/VBox/VBox/Content
@onready var _main_moving: MovingContainer = $CenterContainer/VBoxContainer/MainMoving
@onready var _button_moving: MovingContainer = $CenterContainer/VBoxContainer/ButtonMoving


func open_menu() -> void:
	show()
	_display(true)


func close_menu() -> void:
	_display(false)
	menu_closed.emit()


func _display(is_displayed: bool) -> void:
	var tween: Tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel()
	_animate_drop(tween, _main_moving, is_displayed, _DROP_DURATION)
	_animate_drop(tween, _button_moving, is_displayed, _DROP_DURATION + 0.2)

func _animate_drop(tween: Tween, moving: MovingContainer, is_displayed: bool, duration: float) -> void:
	var to: float = 0.0 if is_displayed else -(10.0 + moving.get_child(0).size.y + get_viewport_rect().get_center().y)
	moving.move_container_from_current(tween, SIDE_TOP, to, duration)


func _on_save_and_exit_button_pressed() -> void:
	Settings.save_settings()
	close_menu()


func _on_reset_button_pressed() -> void:
	var current_settings: SettingsList = settings.get_current_tab_control() as SettingsList
	current_settings.reset_settings()


func _on_visible_notifier_screen_exited() -> void:
	hide()
