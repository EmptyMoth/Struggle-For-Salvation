extends Node


static var _config := ConfigHandler.new("res://settings.cfg")

static var graphics_settings := GraphicsSettings.new(_config)
static var gameplay_settings := GameplaySettings.new(_config)
static var audio_settings := AudioSettings.new(_config)
static var custom_rules_settings := CustomRulesSettings.new(_config)

static var settings: Array[AbstractSettings] = \
[graphics_settings, audio_settings, gameplay_settings, custom_rules_settings]


func _ready() -> void:
	_initialise_parameters()


func reset_settings() -> void:
	for setting in settings:
		setting.reset_settings()


func save_settings() -> void:
	_config.save_config()


func _initialise_parameters() -> void:
	for setting in settings:
		setting.initialise_parameters()
	save_settings()
