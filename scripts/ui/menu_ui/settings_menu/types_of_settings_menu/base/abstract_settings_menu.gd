class_name AbstractSettingsMenu
extends MarginContainer


var _settings_server: AbstractSettingsType

var _option_buttons_settings: Dictionary = {}
var _check_button_settings: Array[String] = []
var _hslider_settings: Array[String] = []


func _ready() -> void:
	init()
	setups_settings()


func setups_option_buttons_settings(
		labels_by_settings: Dictionary, settings: AbstractSettingsType) -> void:
	for setting_name in labels_by_settings:
		var labels: Array = labels_by_settings[setting_name]
		var setting_button: OptionButton = get(setting_name)
		if not setting_button.item_selected.is_connected(_on_option_button_item_selected):
			setting_button.item_selected.connect(
				_on_option_button_item_selected.bindv([setting_name, setting_button, settings]))
		BaseSettingElement.set_labels_in_option_button(
			setting_button, labels, settings.get(setting_name).value)


func setups_check_buttons_settings(
		settings_array: Array[String], settings: AbstractSettingsType) -> void:
	for setting_name in settings_array:
		var setting_button: CheckButton = get(setting_name)
		if not setting_button.toggled.is_connected(_on_check_button_toggled):
			setting_button.toggled.connect(
				_on_check_button_toggled.bindv([setting_name, settings]))
		BaseSettingElement.set_pressed_for_check_button(setting_button, settings.get(setting_name).value)


func setups_hslider_settings(
		settings_array: Array[String], settings: AbstractSettingsType) -> void:
	for setting_name in settings_array:
		var setting_button: HSlider = get(setting_name)
		if not setting_button.drag_ended.is_connected(_on_hslider_drag_ended):
			setting_button.drag_ended.connect(
				_on_hslider_drag_ended.bindv([setting_name, setting_button, settings]))
		BaseSettingElement.set_value_for_h_slider(setting_button, settings.get(setting_name).value)


static func _on_option_button_item_selected(index: int, 
		setting_name: String, settings_button: OptionButton, settings: AbstractSettingsType) -> void:
	var new_value: String = settings_button.get_item_text(index)
	settings.set(setting_name, new_value)


static func _on_check_button_toggled(button_pressed: bool, 
		setting_name: String, settings: AbstractSettingsType) -> void:
	settings.set(setting_name, button_pressed)


static func _on_hslider_drag_ended(value_changed: bool, 
		setting_name: String, hslider: HSlider, settings: AbstractSettingsType) -> void:
	if value_changed:
		settings.set(setting_name, hslider.value)


func init() -> void:
	pass


func set_parameters(
		settings_server: AbstractSettingsType,
		option_buttons_settings: Dictionary) -> void:
	_settings_server = settings_server
	_option_buttons_settings = option_buttons_settings
	for property in get_property_list():
		var property_class: String = property["class_name"]
		if property_class == "CheckButton":
			_check_button_settings.append(property["name"])
		if property_class == "HSlider":
			_hslider_settings.append(property["name"])


func setups_settings() -> void:
	setups_option_buttons_settings(_option_buttons_settings, _settings_server)
	setups_check_buttons_settings(_check_button_settings, _settings_server)
	setups_hslider_settings(_hslider_settings, _settings_server)


func _on_reset_button_pressed() -> void:
	_settings_server.reset_settings()
	setups_settings()
