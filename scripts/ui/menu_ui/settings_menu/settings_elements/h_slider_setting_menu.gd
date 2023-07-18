@tool
extends BaseSettingElementMenu


func get_setting_button() -> HSlider:
	return $CenterContainer/HSlider


func _initial_setup(setting: BaseSettingWithRange) -> void:
	var option_button: HSlider = get_setting_button()
	option_button.min_value = setting.min_value
	option_button.max_value = setting.max_value
	option_button.step = setting.step
	var tick_count: int = setting.get_segment_count()
	option_button.tick_count = tick_count + 1 if tick_count < 10 else 0
	option_button.value = setting.value


func _on_h_slider_value_changed(value: float) -> void:
	_setting.value = value
