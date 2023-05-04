extends Node


enum ResolutionIndex {
	RESOLUTION_NONE = -99,
	RESOLUTION_DEFAULT = 0,
	RESOLUTION_1920_1080 = 0,
	RESOLUTION_1600_900 = 1,
	RESOLUTION_1366_768 = 2,
	RESOLUTION_1280_1024 = 3,
	RESOLUTION_1280_720 = 4,
	RESOLUTION_1152_648 = 5,
	RESOLUTION_1024_768 = 6,
	RESOLUTION_1024_576 = 7,
	RESOLUTION_800_600 = 8,
	RESOLUTION_640_480 = 9,
}

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

const RESOLUTION_BY_INDEX: Dictionary = {
	Vector2(1920, 1080) : ResolutionIndex.RESOLUTION_1920_1080,
	Vector2(1600, 900) : ResolutionIndex.RESOLUTION_1600_900,
	Vector2(1366, 768) : ResolutionIndex.RESOLUTION_1366_768,
	Vector2(1280, 1024) : ResolutionIndex.RESOLUTION_1280_1024,
	Vector2(1280, 720) : ResolutionIndex.RESOLUTION_1280_720,
	Vector2(1152, 648) : ResolutionIndex.RESOLUTION_1152_648,
	Vector2(1024, 768) : ResolutionIndex.RESOLUTION_1024_768,
	Vector2(1024, 576) : ResolutionIndex.RESOLUTION_1024_576,
	Vector2(800, 600) : ResolutionIndex.RESOLUTION_800_600,
	Vector2(640, 480) : ResolutionIndex.RESOLUTION_640_480,
}

const INDEX_BY_RESOLUTION: Dictionary = {
	ResolutionIndex.RESOLUTION_1920_1080 : Vector2(1920, 1080),
	ResolutionIndex.RESOLUTION_1600_900 : Vector2(1600, 900),
	ResolutionIndex.RESOLUTION_1366_768 : Vector2(1366, 768),
	ResolutionIndex.RESOLUTION_1280_1024 : Vector2(1280, 1024),
	ResolutionIndex.RESOLUTION_1280_720 : Vector2(1280, 720),
	ResolutionIndex.RESOLUTION_1152_648 : Vector2(1152, 648),
	ResolutionIndex.RESOLUTION_1024_768 : Vector2(1024, 768),
	ResolutionIndex.RESOLUTION_1024_576 : Vector2(1024, 576),
	ResolutionIndex.RESOLUTION_800_600 : Vector2(800, 600),
	ResolutionIndex.RESOLUTION_640_480 : Vector2(640, 480),
}

var param_init: bool = false

var param_resolution: ResolutionIndex = ResolutionIndex.RESOLUTION_DEFAULT
var param_texture_quality: Quality = Quality.TEXTURE_QUALITY_HIGH
var param_display: Display = Display.DISPLAY_FULLSCREEN
var param_vsync: bool = true
var param_framerate_cap: int = 60
var param_mouse_locked: bool = true
var param_volume_master: int = 100
var param_volume_music: int = 100
var param_volume_effects: int = 100
var param_language: int = Language.LANGUAGE_RUS
var param_action_dice_count: bool = false
var param_music_when_paused: bool = true
var param_custom_rules_enabled: bool = false
var param_enemy_health: float = 1.0
var param_enemy_damage: float = 1.0


#@onready var resolution: Vector2 = \
#	INDEX_BY_RESOLUTION[ResolutionIndex.RESOLUTION_1920_1080]
@onready var location_of_ally_team_on_battlefield: LocationOfAllyTeamOnBattlefield = \
	LocationOfAllyTeamOnBattlefield.LEFT


func _ready():
	pass


func initialise_parameters() -> void:
	param_resolution = Config.get_value("graphics", "resolution")
	param_texture_quality = Config.get_value("graphics", "texture_quality")
	param_display = Config.get_value("graphics", "display")
	param_vsync = Config.get_value("graphics", "vsync")
	param_framerate_cap = Config.get_value("graphics", "framerate_cap")
	param_mouse_locked = Config.get_value("graphics", "mouse_locked")
	param_volume_master = Config.get_value("sound", "volume_master")
	param_volume_music = Config.get_value("sound", "volume_music")
	param_volume_effects = Config.get_value("sound", "volume_effects")
	param_language = Config.get_value("gameplay", "language")
	param_action_dice_count = Config.get_value("gameplay", "action_dice_count")
	param_music_when_paused = Config.get_value("gameplay", "music_when_paused")
	param_custom_rules_enabled = Config.get_value("custom", "custom_rules_enabled")
	param_enemy_health = Config.get_value("custom", "enemy_health")
	param_enemy_damage = Config.get_value("custom", "enemy_damage")
	
	param_init = true


func get_resolution_number(res: Vector2) -> ResolutionIndex:
	return INDEX_BY_RESOLUTION.get(res, ResolutionIndex.RESOLUTION_DEFAULT)


func get_resolution(index: ResolutionIndex = ResolutionIndex.RESOLUTION_NONE) -> Vector2:
	if index == -99:
		index = param_resolution
	
	return RESOLUTION_BY_INDEX.get(index, Vector2(1920, 1080))


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
