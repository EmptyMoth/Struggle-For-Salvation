extends BaseSettingElementMenu


func get_setting_button() -> CheckButton:
	return $CenterContainer/CheckButton


func _initial_setup(setting: BaseSettingsWithToggle) -> void:
	var option_button: CheckButton = get_setting_button()
	option_button.set_pressed_no_signal(setting.is_on)


func _on_check_button_toggled(button_pressed: bool) -> void:
	_setting.value = button_pressed
