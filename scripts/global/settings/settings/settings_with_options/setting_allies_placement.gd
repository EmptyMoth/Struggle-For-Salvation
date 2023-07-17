class_name SettingAlliesPlacement
extends BaseSettingWithOptions


var is_left: bool : 
	get: return value == "Left"


func _init() -> void:
	_options = {
		"Left" = true,
		"Right" = false,
	}
	super("allies_placement", "Left", _options)
