class_name BaseSettingWithOptions
extends AbstractSetting


var current_option: Variant

var _options: Dictionary


func _init(_name: String, _default_value: Variant, options: Dictionary) -> void:
	super(_name, _default_value)
	_options = options


func _set_value(new_value: Variant) -> void:
	value = new_value
	current_option = _options[new_value]
	_execute()
	emit_signal("setting_changed", value)


func get_options() -> Dictionary:
	return _options


func get_items() -> Array[Variant]:
	return _options.keys()
