extends Control


var config: ConfigFile = ConfigFile.new()


func validate_config() -> bool:
	if(config.load("user://config.cfg") != OK):
		config = ConfigFile.new()
	
	if(!config.has_section_key("graphics", "resolution")):
		config.set_value("graphics", "resolution", GlobalParameters.ResolutionIndex.RESOLUTION_1920_1080)
	if(!config.has_section_key("graphics", "texture_quality")):
		config.set_value("graphics", "texture_quality", GlobalParameters.Quality.TEXTURE_QUALITY_HIGH)
	if(!config.has_section_key("graphics", "display")):
		config.set_value("graphics", "display", GlobalParameters.Display.DISPLAY_FULLSCREEN)
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
		config.set_value("gameplay", "language", GlobalParameters.Language.LANGUAGE_RUS)
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
	GlobalParameters.initialise_parameters()
	return true


func save_config() -> void:
	@warning_ignore("return_value_discarded")
	config.save("user://config.cfg")


func get_value(section: String, key: String) -> Variant:
	return config.get_value(section, key)


func set_value(section: String, key: String, value: Variant) -> void:
	config.set_value(section, key, value)
	save_config()
