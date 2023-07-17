class_name BaseSettingElementMenu
extends HBoxContainer


@export_multiline var setting_name: String = ""
@export_multiline var setting_tooltip: String = ""

var _setting: AbstractSetting


func _ready() -> void:
	var _setting_name_label: Label = $SettingName
	_setting_name_label.text = setting_name.to_snake_case().to_upper()
	_setting_name_label.tooltip_text = setting_tooltip.to_snake_case().to_upper()


func get_setting_button():
	return $CenterContainer.get_children().front()


func set_setting(setting) -> void:
	_setting = setting
	setting.setting_changed.connect(_on_setting_changed)
	_initial_setup(setting)


func _initial_setup(setting) -> void:
	_setting = setting


func _on_setting_changed(_value: Variant) -> void:
	_initial_setup(_setting)
