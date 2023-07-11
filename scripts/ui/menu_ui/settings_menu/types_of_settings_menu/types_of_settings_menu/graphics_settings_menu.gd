extends AbstractSettingsMenu


@onready var graphics_quality: OptionButton = $Settings/GraphicsQuality.get_button()
@onready var resolution: OptionButton = $Settings/Resolution.get_button()
@onready var display: OptionButton = $Settings/Display.get_button()
@onready var mouse_locked: CheckButton = $Settings/MouseLocked.get_button()
@onready var limit_max_fps: OptionButton = $Settings/LimitMaxFPS.get_button()
@onready var vsync: CheckButton = $Settings/VSync.get_button()


func init() -> void:
	set_parameters(
		Settings.graphics_settings,
		{
			"graphics_quality" = GraphicsSettings.GRAPHICS_QUALITY.keys(),
			"resolution" = GraphicsSettings.RESOLUTIONS.keys(),
			"display" = GraphicsSettings.DISPLAY.keys(),
			"limit_max_fps" = GraphicsSettings.LIMIT_MAX_FPS.keys(),
		}
	)
