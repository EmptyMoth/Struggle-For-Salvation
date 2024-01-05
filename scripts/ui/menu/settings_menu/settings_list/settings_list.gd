class_name SettingsList
extends VBoxContainer


static var _SETTINGS_GROUPS_BY_TITLE: Dictionary = {
	"Graphics" = Settings.graphics_settings,
	"Gameplay" = Settings.gameplay_settings,
	"Audio" = Settings.audio_settings,
	"CustomRules" = Settings.custom_rules_settings,
}

@export_enum("Graphics", "Gameplay", "Audio", "CustomRules") var settings_title: String = "Graphics"

var settings_server: AbstractSettingsType


func _ready() -> void:
	settings_server = _SETTINGS_GROUPS_BY_TITLE[settings_title]
	var setting_elements: Array[BaseSettingElementMenu] = []
	setting_elements.assign(get_children())
	for i: int in setting_elements.size():
		setting_elements[i].set_setting(settings_server.settings[i])


func reset_settings() -> void: settings_server.set_default_settings()
