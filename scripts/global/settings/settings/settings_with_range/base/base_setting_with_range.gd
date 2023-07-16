class_name BaseSettingWithRange
extends AbstractSetting


var min_value: float = 0
var max_value: float = 100
var step: float = 1


func _init(_name: String, _default_value: Variant, 
			_min_value: float, _max_value: float, _step: float) -> void:
	super(_name, _default_value)
	self.min_value = _min_value
	self.max_value = _max_value
	self.step = _step


func get_segment_count() -> int:
	return int((max_value - min_value) / step)


func _set_value(new_value: Variant) -> void:
	value = clampf(new_value, min_value, max_value)
	_execute()
	emit_signal("setting_changed", new_value)
