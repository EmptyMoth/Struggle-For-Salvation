class_name GraphicsSettings
extends AbstractSettings


signal changed_graphics_quality(new_graphic_quality: int)

const DEFAULT_GRAPHICS_QUALITY: String = "High"
const GRAPHICS_QUALITY: Dictionary = {
	"Low" = 0,
	"Medium" = 1,
	"High" = 2,
}

const DEFAULT_RESOLUTION: String = "1920x1080"
const RESOLUTIONS: Dictionary = {
	"1024x576" = Vector2i(1024, 576),
	"1152x648" = Vector2i(1152, 648),
	"1280x720" = Vector2i(1280, 720),
	"1366x768" = Vector2i(1366, 768),
	"1600x900" = Vector2i(1600, 900),
	"1920x1080" = Vector2i(1920, 1080),
	"2560x1440" = Vector2i(2560, 1440),
}

const DEFAULT_DISPLAY: String = "Fullscreen"
const DISPLAY: Dictionary = {
	"Windowed" = DisplayServer.WINDOW_MODE_WINDOWED,
	"Borderless" = DisplayServer.WINDOW_MODE_WINDOWED + DisplayServer.WINDOW_FLAG_BORDERLESS,
	"Fullscreen" = DisplayServer.WINDOW_MODE_FULLSCREEN,
}

const DEFAULT_LIMIT_MAX_FPS: String = "60"
const LIMIT_MAX_FPS: Dictionary = {
	"30" = 30,
	"60" = 60,
	"120" = 120,
}

var graphics_quality := DEFAULT_GRAPHICS_QUALITY :
	set(value):
		graphics_quality = value
		var new_graphics_quality: int = GRAPHICS_QUALITY[graphics_quality]
		#ProjectSettings.set_setting("rendering/camera/depth_of_field/depth_of_field_bokeh_shape", graphics_quality)
		#ProjectSettings.set_setting("rendering/camera/depth_of_field/depth_of_field_bokeh_quality", graphics_quality)
		#RenderingServer.viewport_set_occlusion_culling_build_quality(graphics_quality as RenderingServer.ViewportOcclusionCullingBuildQuality)
		emit_signal("changed_graphics_quality", new_graphics_quality)
		_save_change_setting("graphics_quality", graphics_quality)
var resolution: String = DEFAULT_RESOLUTION :
	set(value):
		value = value.replace(" ", "")
		resolution = value
		DisplayServer.window_set_size(RESOLUTIONS[resolution])
		var new_window_position: Vector2i = \
			(DisplayServer.screen_get_size() - DisplayServer.window_get_size()) / 2
		DisplayServer.window_set_position(new_window_position)
		_save_change_setting("resolution", resolution)
var display := DEFAULT_DISPLAY :
	set(value):
		display = value
		var new_window_mode = DISPLAY[display]
		if new_window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(new_window_mode)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, 
				new_window_mode != DisplayServer.WINDOW_MODE_WINDOWED)
		_save_change_setting("display", display)
var mouse_locked: bool = true :
	set(value):
		mouse_locked = value
		DisplayServer.mouse_set_mode(
			DisplayServer.MOUSE_MODE_CONFINED 
			if mouse_locked 
			else DisplayServer.MOUSE_MODE_VISIBLE
		)
		_save_change_setting("mouse_locked", mouse_locked)
var limit_max_fps := DEFAULT_LIMIT_MAX_FPS :
	set(value):
		limit_max_fps = value
		var new_max_fps: int = LIMIT_MAX_FPS[limit_max_fps]
		Engine.max_fps = new_max_fps
		Engine.physics_ticks_per_second = max(60, new_max_fps)
		_save_change_setting("limit_max_fps", limit_max_fps)
var vsync := true :
	set(value):
		vsync = value
		DisplayServer.window_set_vsync_mode(
			DisplayServer.VSYNC_ADAPTIVE
			if vsync
			else DisplayServer.VSYNC_DISABLED
		)
		_save_change_setting("vsync", vsync)


func _init(config: ConfigHandler) -> void:
	super(config, "graphics")
