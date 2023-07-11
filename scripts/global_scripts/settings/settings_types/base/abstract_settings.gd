class_name AbstractSettings
extends RefCounted


var settings_type: String = ""
var default_settings: Array[Array] = []

var _config: ConfigHandler = null


func _init(config: ConfigHandler, current_settings_type: String) -> void:
	settings_type = current_settings_type
	_create_array_default_settings()
	_config = config
	_config.validate_config(default_settings)


func _get_property_list() -> Array:
	return get_script().get_script_property_list()\
		.filter(func(x): return x.name not in ["settings_type", "default_settings"] \
			and not x.name.begins_with("_")\
			and not x.name.ends_with(".gd")
	)


func initialise_parameters() -> void:
	for setting in _get_property_list():
		var setting_value = _config.get_value(settings_type, setting.name)
		set(setting.name, setting_value)


func reset_settings():
	for setting in default_settings:
		set(setting[1], setting[2])


func _save_change_setting(seting_name: String, setting_value: Variant) -> void:
	_config.set_value(settings_type, seting_name, setting_value)


func _create_array_default_settings() -> void:
	for property in _get_property_list():
		var property_value: Variant = get(property.name)
		var setting: Array = [settings_type, property.name, property_value]
		default_settings.append(setting)
