extends Control


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

var config: ConfigFile = ConfigFile.new()


func validate_config() -> bool:
	if(config.load("user://config.cfg") != OK):
		config = ConfigFile.new()
	
	if(!config.has_section_key("graphics", "resolution")):
		config.set_value("graphics", "resolution", ResolutionIndex.RESOLUTION_1920_1080)
	if(!config.has_section_key("graphics", "texture_quality")):
		config.set_value("graphics", "texture_quality", Quality.TEXTURE_QUALITY_HIGH)
	if(!config.has_section_key("graphics", "display")):
		config.set_value("graphics", "display", Display.DISPLAY_FULLSCREEN)
	if(!config.has_section_key("graphics", "vsync")):
		config.set_value("graphics", "vsync", true)
	if(!config.has_section_key("graphics", "framerate_cap")):
		config.set_value("graphics", "framerate_cap", 60)
	if(!config.has_section_key("graphics", "mouse_locked")):
		config.set_value("graphics", "mouse_locked", true)
	
	if(!config.has_section_key("sound", "volume_master")):
		config.set_value("sound", "volume_master", 100)
	if(!config.has_section_key("sound", "volume_music")):
		config.set_value("sound", "volume_music", 100)
	if(!config.has_section_key("sound", "volume_effects")):
		config.set_value("sound", "volume_effects", 100)
	
	if(!config.has_section_key("gameplay", "language")):
		config.set_value("gameplay", "language", Language.LANGUAGE_RUS)
	if(!config.has_section_key("gameplay", "action_dice_count")):
		config.set_value("gameplay", "action_dice_count", false)
	if(!config.has_section_key("gameplay", "music_when_paused")):
		config.set_value("gameplay", "music_when_paused", true)
	
	if(!config.has_section_key("custom", "custom_rules_enabled")):
		config.set_value("custom", "custom_rules_enabled", false)
	if(!config.has_section_key("custom", "enemy_health")):
		config.set_value("custom", "enemy_health", 1.0)
	if(!config.has_section_key("custom", "enemy_damage")):
		config.set_value("custom", "enemy_damage", 1.0)
	
	save_config()
	return true


func save_config() -> void:
	@warning_ignore("return_value_discarded")
	config.save("user://config.cfg")


func get_value(section: String, key: String) -> Variant:
	return config.get_value(section, key)


func set_value(section: String, key: String, value: Variant) -> void:
	config.set_value(section, key, value)
	save_config()


func get_resolution_number(res: Vector2) -> int:
	return INDEX_BY_RESOLUTION.get(res, ResolutionIndex.RESOLUTION_DEFAULT)

func get_resolution(index: int = -99) -> Vector2:
	if(index == -99):
		index = get_value("graphics", "resolution")
	
	return RESOLUTION_BY_INDEX.get(index, Vector2(1920, 1080))


func get_display_mode(index: int) -> int:
	match index:
		Display.DISPLAY_FULLSCREEN:
			return DisplayServer.WINDOW_MODE_FULLSCREEN
		Display.DISPLAY_WINDOWED:
			return DisplayServer.WINDOW_MODE_WINDOWED
		Display.DISPLAY_BORDERLESS:
			return DisplayServer.WINDOW_MODE_WINDOWED
	return DisplayServer.WINDOW_MODE_WINDOWED
