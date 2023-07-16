class_name GraphicsSettings
extends AbstractSettingsType


static var graphics_quality := SettingGraphicsQuality.new()
static var resolution := SettingResolution.new()
static var display := SettingDisplay.new()
static var mouse_locked := SettingMouseLocked.new()
static var limit_max_fps := SettingLimitMaxFPS.new()
static var vsync := SettingVSync.new()


func _init(config: ConfigHandler) -> void:
	settings = [graphics_quality, resolution, display, mouse_locked, limit_max_fps, vsync]
	super("graphics", settings, config)
