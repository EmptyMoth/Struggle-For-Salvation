extends Control


var config: ConfigFile = ConfigFile.new()


func validate_config() -> bool:
	if(config.load("user://config.cfg") != OK):
		config = ConfigFile.new()
	
	if(!config.has_section_key("graphics", "resolution")):
		config.set_value("graphics", "resolution", Settings.param_resolution)
	if(!config.has_section_key("graphics", "texture_quality")):
		config.set_value("graphics", "texture_quality", Settings.param_texture_quality)
	if(!config.has_section_key("graphics", "display")):
		config.set_value("graphics", "display", Settings.param_display)
	if(!config.has_section_key("graphics", "vsync")):
		config.set_value("graphics", "vsync", Settings.param_vsync)
	if(!config.has_section_key("graphics", "framerate_cap")):
		config.set_value("graphics", "framerate_cap", Settings.param_framerate_cap)
	if(!config.has_section_key("graphics", "mouse_locked")):
		config.set_value("graphics", "mouse_locked", Settings.param_mouse_locked)
	
	if(!config.has_section_key("sound", "volume_master")):
		config.set_value("sound", "volume_master", Settings.param_volume_msater)
	if(!config.has_section_key("sound", "volume_music")):
		config.set_value("sound", "volume_music", Settings.param_volume_music)
	if(!config.has_section_key("sound", "volume_effects")):
		config.set_value("sound", "volume_effects", Settings.param_volume_effects)
	
	if(!config.has_section_key("gameplay", "language")):
		config.set_value("gameplay", "language", Settings.param_language)
	if(!config.has_section_key("gameplay", "action_dice_count")):
		config.set_value("gameplay", "action_dice_count", Settings.param_action_dice_count)
	if(!config.has_section_key("gameplay", "music_when_paused")):
		config.set_value("gameplay", "music_when_paused", Settings.param_music_when_paused)
	
	if(!config.has_section_key("custom", "custom_rules_enabled")):
		config.set_value("custom", "custom_rules_enabled", Settings.param_custom_rules_enabled)
	if(!config.has_section_key("custom", "enemy_health")):
		config.set_value("custom", "enemy_health", Settings.param_enemy_health)
	if(!config.has_section_key("custom", "enemy_damage")):
		config.set_value("custom", "enemy_damage", Settings.param_enemy_damage)
	
	Settings.initialise_parameters()
	save_config()
	return true


func save_config() -> void:
	config.set_value("graphics", "resolution", Settings.param_resolution)
	config.set_value("graphics", "texture_quality", Settings.param_texture_quality)
	config.set_value("graphics", "display", Settings.param_display)
	config.set_value("graphics", "vsync", Settings.param_vsync)
	config.set_value("graphics", "framerate_cap", Settings.param_framerate_cap)
	config.set_value("graphics", "mouse_locked", Settings.param_mouse_locked)
	
	config.set_value("sound", "volume_master", Settings.param_volume_master)
	config.set_value("sound", "volume_music", Settings.param_volume_music)
	config.set_value("sound", "volume_effects", Settings.param_volume_effects)
	
	config.set_value("gameplay", "language", Settings.param_language)
	config.set_value("gameplay", "action_dice_count", Settings.param_action_dice_count)
	config.set_value("gameplay", "music_when_paused", Settings.param_music_when_paused)
	
	config.set_value("custom", "custom_rules_enabled", Settings.param_custom_rules_enabled)
	config.set_value("custom", "enemy_health", Settings.param_enemy_health)
	config.set_value("custom", "enemy_damage", Settings.param_enemy_damage)
	
	@warning_ignore("return_value_discarded")
	config.save("user://config.cfg")


func get_value(section: String, key: String) -> Variant:
	return config.get_value(section, key)


func set_value(section: String, key: String, value: Variant) -> void:
	config.set_value(section, key, value)
