extends Node


enum ResolutionIndex {
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

var param_resolution: int
var param_texture_quality: int
var param_display: int
var param_vsync: bool
var param_framerate_cap: int
var param_mouse_locked: bool
var param_volume_master: int
var param_volume_music: int
var param_volume_effects: int
var param_language: int
var param_action_dice_count: bool
var param_music_when_paused: bool
var param_custom_rules_enabled: bool
var param_enemy_health: float
var param_enemy_damage: float


@onready var random: RandomNumberGenerator = RandomNumberGenerator.new() :
	get: return random


@onready var resolution: Vector2 = \
	INDEX_BY_RESOLUTION[ResolutionIndex.RESOLUTION_1920_1080]
@onready var location_of_ally_team_on_battlefield: LocationOfAllyTeamOnBattlefield = \
	LocationOfAllyTeamOnBattlefield.LEFT


func _ready() -> void:
	random.randomize()


func _input(_event: InputEvent) -> void:
	return
	if Input.is_action_pressed("ui_menu"):
		get_tree().quit()


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


func get_resolution_number(res: Vector2) -> int:
	return INDEX_BY_RESOLUTION.get(res, ResolutionIndex.RESOLUTION_DEFAULT)


func get_resolution(index: int = -99) -> Vector2:
	if index == -99:
		index = param_resolution
	
	return RESOLUTION_BY_INDEX.get(index, Vector2(1920, 1080))


func get_display_mode(index: int) -> int:
	match index:
		Display.DISPLAY_FULLSCREEN:
			return DisplayServer.WINDOW_MODE_FULLSCREEN
		Display.DISPLAY_WINDOWED:
			return DisplayServer.WINDOW_MODE_WINDOWED
		Display.DISPLAY_BORDERLESS:
			return DisplayServer.WINDOW_MODE_WINDOWED
		_:
			return DisplayServer.WINDOW_MODE_WINDOWED
