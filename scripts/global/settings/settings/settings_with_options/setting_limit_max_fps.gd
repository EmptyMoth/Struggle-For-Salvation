class_name SettingLimitMaxFPS
extends BaseSettingWithOptions


func _init() -> void:
	_options = {
		"30" = 30,
		"60" = 60,
		"120" = 120,
	}
	super("limit_max_fps", "60", _options)


func _execute() -> void:
	Engine.max_fps = current_option
	#Engine.physics_ticks_per_second = max(60, current_option)
