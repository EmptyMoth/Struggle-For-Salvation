class_name SettingAlliesPlacement
extends BaseSettingWithOptions


var is_left: bool : 
	get: return value == default_value


func _init() -> void:
	_options = {
		"LEFT" = true,
		"RIGHT" = false,
	}
	super("allies_placement", "LEFT", _options)
