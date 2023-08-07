extends AbstractSettingsMenu


func _ready() -> void:
	_settings_server = Settings.graphics_settings
	$Settings/GraphicsQuality.set_setting(_settings_server.graphics_quality)
	$Settings/Resolution.set_setting(_settings_server.resolution)
	$Settings/Display.set_setting(_settings_server.display)
	$Settings/MouseLocked.set_setting(_settings_server.mouse_locked)
	$Settings/LimitMaxFPS.set_setting(_settings_server.limit_max_fps)
	$Settings/VSync.set_setting(_settings_server.vsync)
