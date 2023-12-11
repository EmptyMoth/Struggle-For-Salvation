class_name AbstractSettingsType
extends RefCounted


var settings_type: String = "null"
var settings: Array[AbstractSetting] = []

var _config: ConfigHandler = null


func _init(_settings_type: String, _settings: Array[AbstractSetting], 
			config: ConfigHandler) -> void:
	settings_type = _settings_type
	settings = _settings
	_config = config
	for setting: AbstractSetting in settings:
		_config.validate_value(settings_type, setting.name, setting.default_value)


func save_settings() -> void:
	for setting: AbstractSetting in settings:
		_config.set_value(settings_type, setting.name, setting.value)


func initialise_settings() -> void:
	for setting: AbstractSetting in settings:
		var setting_value: Variant = _config.get_value(settings_type, setting.name)
		setting.value = setting_value


func set_default_settings() -> void:
	for setting: AbstractSetting in settings:
		setting.set_defaut_value()
