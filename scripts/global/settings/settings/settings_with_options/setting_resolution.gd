class_name SettingResolution
extends BaseSettingWithOptions


func _init() -> void:
	_options = {
		"1024x576" = Vector2i(1024, 576),
		"1152x648" = Vector2i(1152, 648),
		"1280x720" = Vector2i(1280, 720),
		"1366x768" = Vector2i(1366, 768),
		"1600x900" = Vector2i(1600, 900),
		"1920x1080" = Vector2i(1920, 1080),
		"2560x1440" = Vector2i(2560, 1440),
	}
	super("resolution", "1920x1080", _options)


func _execute() -> void:
	DisplayServer.window_set_size(current_option)
	var new_window_position: Vector2i = \
		(DisplayServer.screen_get_size() - DisplayServer.window_get_size()) / 2
	DisplayServer.window_set_position(new_window_position)
