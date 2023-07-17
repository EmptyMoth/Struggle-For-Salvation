@tool
extends BaseSettingElementMenu


func get_setting_button() -> OptionButton:
	return $CenterContainer/OptionButton


func _initial_setup(setting: BaseSettingWithOptions) -> void:
	var option_button: OptionButton = get_setting_button()
	if option_button.item_count <= 0:
		for item_text in setting.get_items():
			option_button.add_item(item_text)
	
	for index in option_button.item_count:
		var item_text: String = option_button.get_item_text(index)
		if item_text == setting.value:
			option_button.select(index)


func _on_option_button_item_selected(index: int) -> void:
	_setting.value = get_setting_button().get_item_text(index)
