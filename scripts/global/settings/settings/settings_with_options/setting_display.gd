class_name SettingDisplay
extends BaseSettingWithOptions


func _init() -> void:
	_options = {
		"WINDOWED" = DisplayServer.WINDOW_MODE_WINDOWED,
		"BORDERLESS" = DisplayServer.WINDOW_MODE_WINDOWED + DisplayServer.WINDOW_FLAG_BORDERLESS,
		"FULLSCREEN" = DisplayServer.WINDOW_MODE_FULLSCREEN,
	}
	super("display", "FULLSCREEN", _options)


func _execute() -> void:
	if current_option == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(current_option)
		return
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, 
		current_option != DisplayServer.WINDOW_MODE_WINDOWED)
	Settings.graphics_settings.resolution.value = Settings.graphics_settings.resolution.value
