extends Node


static var _config := ConfigHandler.new("res://settings.cfg")

static var graphics_settings := GraphicsSettings.new(_config)
static var gameplay_settings := GameplaySettings.new(_config)
static var audio_settings := AudioSettings.new(_config)
static var custom_rules_settings := CustomRulesSettings.new(_config)

static var settings: Array[AbstractSettingsType] = \
[graphics_settings, audio_settings, gameplay_settings, custom_rules_settings]


func _ready() -> void:
	_initialise_settings()


func set_default_settings() -> void:
	for setting: AbstractSettingsType in settings:
		setting.set_default_settings()


func save_settings() -> void:
	for setting: AbstractSettingsType in settings:
		setting.save_settings()
	_config.save_config()


func _initialise_settings() -> void:
	for setting: AbstractSettingsType in settings:
		setting.initialise_settings()
	save_settings()
