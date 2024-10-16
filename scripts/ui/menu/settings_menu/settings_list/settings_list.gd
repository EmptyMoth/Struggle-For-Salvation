class_name SettingsList
extends VBoxContainer


const _PACKED_WITH_OPTION_SETTING: PackedScene = preload("res://scenes/ui/menu/settings_menu/settings_elements/option_button_setting_menu.tscn")
const _PACKED_WITH_CHECK_SETTING: PackedScene = preload("res://scenes/ui/menu/settings_menu/settings_elements/check_button_setting_menu.tscn")
const _PACKED_WITH_SLIDER_SETTING: PackedScene = preload("res://scenes/ui/menu/settings_menu/settings_elements/h_slider_setting_menu.tscn")

static var _SETTINGS_GROUPS_BY_TITLE: Dictionary = {
	"Graphics" = Settings.graphics_settings,
	"Gameplay" = Settings.gameplay_settings,
	"Audio" = Settings.audio_settings,
	"CustomRules" = Settings.custom_rules_settings,
}

@export_enum("Graphics", "Gameplay", "Audio", "CustomRules") var settings_title: String = "Graphics"
@export var hebrew_text: StringName = ""

var settings_server: AbstractSettingsType


func _ready() -> void:
	settings_server = _SETTINGS_GROUPS_BY_TITLE[settings_title]
	var setting_elements: Array[BaseSettingElementMenu] = []
	setting_elements.assign(get_children())
	for setting: AbstractSetting in settings_server.settings:
		var setting_button: BaseSettingElementMenu = _create_setting_button(setting)
		add_child(setting_button)
		setting_button.call_deferred("set_setting", setting)


func reset_settings() -> void: settings_server.set_default_settings()


func _create_setting_button(setting: AbstractSetting) -> BaseSettingElementMenu:
	if setting is BaseSettingWithOptions:
		return _PACKED_WITH_OPTION_SETTING.instantiate()
	if setting is BaseSettingsWithToggle:
		return _PACKED_WITH_CHECK_SETTING.instantiate()
	if setting is BaseSettingWithRange:
		return _PACKED_WITH_SLIDER_SETTING.instantiate()
	return null
