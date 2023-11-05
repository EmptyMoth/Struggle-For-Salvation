class_name AbstractSetting
extends RefCounted


signal setting_changed(new_value: Variant)

var name: String = "null"
var default_value: Variant
var value: Variant : set = _set_value


func _init(_name: String, _default_value: Variant) -> void:
	name = _name
	default_value = _default_value


func set_defaut_value() -> void:
	value = default_value


func _set_value(new_value: Variant) -> void:
	value = new_value	
	_execute()
	emit_signal("setting_changed", new_value)


func _execute() -> void:
	pass
