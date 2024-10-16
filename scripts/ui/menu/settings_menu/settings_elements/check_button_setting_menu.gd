extends BaseSettingElementMenu


func get_setting_button() -> SettingCheckBox:
	return $CenterContainer/CheckBox


func _initial_setup(setting: BaseSettingsWithToggle) -> void:
	var option_button: SettingCheckBox = get_setting_button()
	option_button.set_pressed_without_signal(setting.is_on)


func _on_check_box_toggled(button_pressed: bool) -> void:
	_setting.value = button_pressed
