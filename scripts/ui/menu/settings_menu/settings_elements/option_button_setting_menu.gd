extends BaseSettingElementMenu


func get_setting_button() -> SettingOptionButton:
	return $CenterContainer/OptionButton


func _initial_setup(setting: BaseSettingWithOptions) -> void:
	var option_button: SettingOptionButton = get_setting_button()
	if option_button.item_count <= 0:
		for item_text: String in setting.get_items():
			option_button.add_item(item_text)
	
	for index: int in option_button.item_count:
		var item_text: String = option_button.get_item_text(index)
		if item_text == setting.value:
			option_button.select_item(index)


func _on_option_button_item_selected(index: int) -> void:
	_setting.value = get_setting_button().get_item_text(index)
