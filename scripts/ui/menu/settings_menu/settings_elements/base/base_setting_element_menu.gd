class_name BaseSettingElementMenu
extends HBoxContainer


@onready var _setting_name_label: Label = $SettingName

@export_multiline var setting_name: String = "" :
	set(new_value):
		setting_name = new_value
		if is_node_ready():
			_setting_name_label.text = new_value
@export_multiline var setting_tooltip: String = ""

var _setting: AbstractSetting


func _ready() -> void:
	_setting_name_label.text = setting_name
	_setting_name_label.tooltip_text = setting_tooltip \
			if setting_tooltip != "" \
			else ("%s_TOOLTIP" % setting_name.to_upper())


func get_setting_button() -> Node:
	return $CenterContainer.get_children().front()


func set_setting(setting: AbstractSetting) -> void:
	_setting = setting
	setting.setting_changed.connect(_on_setting_changed)
	_initial_setup(setting)


@warning_ignore("untyped_declaration")
func _initial_setup(setting) -> void:
	_setting = setting


func _on_setting_changed(_value: Variant) -> void:
	_initial_setup(_setting)
