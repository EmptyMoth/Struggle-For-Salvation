class_name BaseSettingElementMenu
extends HBoxContainer


var _setting: AbstractSetting


func get_setting_button() -> Node:
	return $CenterContainer.get_children().front()


func set_setting(setting: AbstractSetting) -> void:
	_setting = setting
	_set_title_and_tooltip(setting.name)
	setting.setting_changed.connect(_on_setting_changed)
	_initial_setup(setting)


@warning_ignore("untyped_declaration")
func _initial_setup(setting) -> void:
	pass


func _set_title_and_tooltip(setting_title: String) -> void:
	var setting_name_label: Label = $SettingName
	setting_name_label.text = setting_title.to_upper()
	setting_name_label.tooltip_text = "%s_TOOLTIP" % setting_name_label.text


func _on_setting_changed(_value: Variant) -> void:
	_initial_setup(_setting)
