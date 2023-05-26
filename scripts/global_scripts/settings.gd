extends Node


enum Display {
	DISPLAY_DEFAULT = 1,
	DISPLAY_FULLSCREEN = 0,
	DISPLAY_WINDOWED = 1,
	DISPLAY_BORDERLESS = 2,
}

enum Quality {
	TEXTURE_QUALITY_LOW = 0,
	TEXTURE_QUALITY_MEDIUM = 1,
	TEXTURE_QUALITY_HIGH = 2,
}

enum Language {
	LANGUAGE_RUS = 0,
	LANGUAGE_ENG = 1,
}

enum LocationOfAllyTeamOnBattlefield { RIGHT, LEFT }

const Resolutions: Dictionary = {
	"1920x1080" : Vector2(1920, 1080),
	"1600x900" : Vector2(1600, 900),
	"1366x768" : Vector2(1366, 768),
	"1280x1024" : Vector2(1280, 1024),
	"1152x648" : Vector2(1152, 648),
	"1024x768" : Vector2(1024, 768),
	"1024x576" : Vector2(1024, 576),
	"800x600" : Vector2(800, 600),
	"640x480" : Vector2(640, 480)
}

const SETTING_VALIDATION_ARRAY: Array = [
	["graphics", "resolution", "1920x1080"],
	["graphics", "texture_quality", Quality.TEXTURE_QUALITY_HIGH],
	["graphics", "display", Display.DISPLAY_DEFAULT],
	["graphics", "vsync", true],
	["graphics", "framerate_cap", fps_multiplier],
	["graphics", "mouse_locked", true],
	["sound", "volume_master", 100],
	["sound", "volume_music", 100],
	["sound", "volume_effects", 100],
	["gameplay", "language", Language.LANGUAGE_RUS],
	["gameplay", "action_dice_count", false],
	["gameplay", "music_when_paused", true],
	["custom", "custom_rules_enabled", false],
	["custom", "enemy_health", 1.0],
	["custom", "enemy_damage", 1.0]
]

const fps_multiplier: int = 60

var param_resolution: String = "1920x1080" :
	set(value):
		param_resolution = value
		_config.set_value("graphics", "resolution", value)

var param_texture_quality: Quality = Quality.TEXTURE_QUALITY_HIGH :
	set(value):
		param_texture_quality = value
		_config.set_value("graphics", "texture_quality", value)

var param_display: Display = Display.DISPLAY_FULLSCREEN :
	set(value):
		param_display = value
		_config.set_value("graphics", "display", value)

var param_vsync: bool = true :
	set(value):
		param_vsync = value
		_config.set_value("graphics", "vsync", value)

var param_framerate_cap: int = fps_multiplier :
	set(value):
		param_framerate_cap = value
		_config.set_value("graphics", "framerate_cap", value)

var param_mouse_locked: bool = true :
	set(value):
		param_mouse_locked = value
		_config.set_value("graphics", "mouse_locked", value)

var param_volume_master: int = 100 :
	set(value):
		param_volume_master = value
		_config.set_value("sound", "volume_master", value)

var param_volume_music: int = 100 :
	set(value):
		param_volume_music = value
		_config.set_value("sound", "volume_music", value)

var param_volume_effects: int = 100 :
	set(value):
		param_volume_effects = value
		_config.set_value("sound", "volume_effects", value)

var param_language: int = Language.LANGUAGE_RUS :
	set(value):
		param_language = value
		_config.set_value("gameplay", "language", value)

var param_action_dice_count: bool = false :
	set(value):
		param_action_dice_count = value
		_config.set_value("gameplay", "action_dice_count", value)

var param_music_when_paused: bool = true :
	set(value):
		param_music_when_paused = value
		_config.set_value("gameplay", "music_when_paused", value)

var param_custom_rules_enabled: bool = false :
	set(value):
		param_custom_rules_enabled = value
		_config.set_value("custom", "custom_rules_enabled", value)

var param_enemy_health: float = 1.0 :
	set(value):
		param_enemy_health = value
		_config.set_value("custom", "enemy_health", value)

var param_enemy_damage: float = 1.0 :
	set(value):
		param_enemy_damage = value
		_config.set_value("custom", "enemy_damage", value)

var _config: ConfigHandler

#@onready var resolution: Vector2 = \
#	INDEX_BY_RESOLUTION[ResolutionIndex.RESOLUTION_1920_1080]
@onready var location_of_ally_team_on_battlefield: LocationOfAllyTeamOnBattlefield = \
	LocationOfAllyTeamOnBattlefield.LEFT


func _ready():
	_config = ConfigHandler.new("user://settings.cfg", SETTING_VALIDATION_ARRAY)
	
	initialise_parameters()
	_config.save_config()
	
	apply_mouse_mode()
	apply_vsync_mode()
	apply_fps()
	apply_display_mode()
	apply_resolution()


func save_settings() -> void:
	_config.save_config()


func initialise_parameters() -> void:
	param_resolution = _config.get_value("graphics", "resolution")
	param_texture_quality = _config.get_value("graphics", "texture_quality")
	param_display = _config.get_value("graphics", "display")
	param_vsync = _config.get_value("graphics", "vsync")
	param_framerate_cap = _config.get_value("graphics", "framerate_cap")
	param_mouse_locked = _config.get_value("graphics", "mouse_locked")
	param_volume_master = _config.get_value("sound", "volume_master")
	param_volume_music = _config.get_value("sound", "volume_music")
	param_volume_effects = _config.get_value("sound", "volume_effects")
	param_language = _config.get_value("gameplay", "language")
	param_action_dice_count = _config.get_value("gameplay", "action_dice_count")
	param_music_when_paused = _config.get_value("gameplay", "music_when_paused")
	param_custom_rules_enabled = _config.get_value("custom", "custom_rules_enabled")
	param_enemy_health = _config.get_value("custom", "enemy_health")
	param_enemy_damage = _config.get_value("custom", "enemy_damage")


func apply_resolution(index: String = "") -> void:
	DisplayServer.window_set_size(get_resolution(index))
	#get_viewport().size = get_resolution(index)

func get_resolution(index: String = "") -> Vector2:
	if index == "":
		index = param_resolution
	
	return Resolutions[index]


func get_display_mode(index: Display) -> int:
	match index:
		Display.DISPLAY_FULLSCREEN:
			return DisplayServer.WINDOW_MODE_FULLSCREEN
		Display.DISPLAY_WINDOWED:
			return DisplayServer.WINDOW_MODE_WINDOWED
		Display.DISPLAY_BORDERLESS:
			return DisplayServer.WINDOW_MODE_WINDOWED
		_:
			return DisplayServer.WINDOW_MODE_WINDOWED

func apply_display_mode() -> void:
	var display_mode = param_display
	
	if(display_mode == Display.DISPLAY_BORDERLESS):
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	
	DisplayServer.window_set_mode(get_display_mode(display_mode))


func apply_mouse_mode() -> void:
	if param_mouse_locked:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CONFINED)
	else:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)


func apply_vsync_mode() -> void:
	if param_vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func apply_fps() -> void:
	ProjectSettings.set_setting("application/run/max_fps", param_framerate_cap)
