@tool
class_name BaseSettingElement
extends HBoxContainer


@export_multiline var setting_name: String = "" :
	set(new_value):
		setting_name = new_value
		if is_node_ready():
			_setting_name_label.text = setting_name

@onready var _setting_name_label: Label = $SettingName
@onready var _button: Control = $CenterContainer.get_children().front()


func _ready() -> void:
	_setting_name_label.text = setting_name.to_snake_case().to_upper()


static func set_labels_in_option_button(
		option_button: OptionButton, labels: Array, current_label: String) -> void:
	if option_button.item_count <= 0:
		for label in labels:
			option_button.add_item(label)
	
	for index in option_button.item_count:
		var label: String = option_button.get_item_text(index)
		if label == current_label:
			option_button.select(index)


static func set_pressed_for_check_button(
		check_button: CheckButton, is_active: bool) -> void:
	check_button.set_pressed_no_signal(is_active)


static func set_value_for_h_slider(
		slider: HSlider, new_value: float) -> void:
	slider.set_value_no_signal(new_value)


func get_setting_name() -> String:
	return _setting_name_label.text


func get_button() -> Control:
	return _button
