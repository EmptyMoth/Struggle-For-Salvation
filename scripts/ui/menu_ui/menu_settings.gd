extends Control


signal exit_menu


func _ready() -> void:
	init()

func init() -> void:
	@warning_ignore("return_value_discarded")
	if(!GlobalParameters.param_init):
		Config.validate_config()
	
	var path: HBoxContainer = $MenuSettings/VBoxContainer/HBoxContainer
	var settings: VBoxContainer = path.get_node("SettingsGameplay")
	settings.get_node("Language/OptionButton").selected = GlobalParameters.param_language
	settings.get_node("ActionDice/CheckButton").button_pressed = GlobalParameters.param_action_dice_count
	settings.get_node("MusicWhenPaused/CheckButton").button_pressed = GlobalParameters.param_music_when_paused
	
	settings.get_node("CustomRules/CheckButton").button_pressed = GlobalParameters.param_custom_rules_enabled
	settings.get_node("EnemyHealth/HSlider").value = GlobalParameters.param_enemy_health
	settings.get_node("EnemyDamage/HSlider").value = GlobalParameters.param_enemy_damage
	
	settings = path.get_node("SettingsSound")
	settings.get_node("VolumeMaster/HSlider").value = GlobalParameters.param_volume_master
	settings.get_node("VolumeMusic/HSlider").value = GlobalParameters.param_volume_music
	settings.get_node("VolumeEffects/HSlider").value = GlobalParameters.param_volume_effects
	
	settings = path.get_node("SettingsGraphics")
	settings.get_node("Resolution/OptionButton").selected = GlobalParameters.param_resolution
	settings.get_node("Display/OptionButton").selected = GlobalParameters.param_display
	settings.get_node("TextureQuality/OptionButton").selected = GlobalParameters.param_texture_quality
	settings.get_node("Vsync/CheckButton").button_pressed = GlobalParameters.param_vsync
	settings.get_node("FramerateCap/OptionButton").selected = GlobalParameters.param_framerate_cap / 60
	settings.get_node("MouseLock/CheckButton").button_pressed = GlobalParameters.param_mouse_locked
	
	set_display_mode()
	set_resolution()
	set_mouse_mode()
	set_vsync_mode()
	set_fps()


func set_resolution() -> void:
	get_viewport().size = GlobalParameters.get_resolution()
	DisplayServer.window_set_size(GlobalParameters.get_resolution())
#	match GlobalParameters.param_display:
#		GlobalParameters.Display.DISPLAY_WINDOWED:
#			get_viewport().size = GlobalParameters.get_resolution()
#			DisplayServer.window_set_size(Config.get_resolution())
#		GlobalParameters.Display.DISPLAY_BORDERLESS:
#			get_viewport().size = GlobalParameters.get_resolution()
#			DisplayServer.window_set_size(Config.get_resolution())
#			#DisplayServer.window_set_size(DisplayServer.screen_get_size())
#			#DisplayServer.window_set_position(Vector2i(0, 0))
#		GlobalParameters.Display.DISPLAY_FULLSCREEN:
#			get_viewport().size = GlobalParameters.get_resolution()
#			DisplayServer.window_set_size(Config.get_resolution())
#			#DisplayServer.window_set_size(get_resolution(config.get_value("graphics", "resolution")))

func set_display_mode() -> void:
	var display_mode = GlobalParameters.param_display
	
	if(display_mode == GlobalParameters.Display.DISPLAY_BORDERLESS):
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	
	DisplayServer.window_set_mode(GlobalParameters.get_display_mode(display_mode))

func set_mouse_mode() -> void:
	if(GlobalParameters.param_mouse_locked):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CONFINED)
	else:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)

func set_vsync_mode() -> void:
	if(GlobalParameters.param_vsync):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func set_fps() -> void:
	ProjectSettings.set_setting("application/run/max_fps", GlobalParameters.param_framerate_cap)


func _on_volume_master_value_changed(value: int) -> void:
	Config.set_value("sound", "volume_master", value)
	GlobalParameters.param_volume_master = value

func _on_volume_music_value_changed(value: int) -> void:
	Config.set_value("sound", "volume_music", value)
	GlobalParameters.param_volume_music = value

func _on_volume_effects_value_changed(value: int) -> void:
	Config.set_value("sound", "volume_effects", value)
	GlobalParameters.param_volume_effects = value


func _on_resolution_item_selected(index: int) -> void:
	Config.set_value("graphics", "resolution", index)
	GlobalParameters.param_resolution = index
	set_display_mode()
	set_resolution()

func _on_display_item_selected(index: int) -> void:
	Config.set_value("graphics", "display", index)
	GlobalParameters.param_display = index
	set_display_mode()
	set_resolution()

func _on_texture_quality_item_selected(index: int) -> void:
	Config.set_value("graphics", "texture_quality", index)
	GlobalParameters.param_texture_quality = index

func _on_vsync_toggled(button_pressed: bool) -> void:
	Config.set_value("graphics", "vsync", button_pressed)
	GlobalParameters.param_vsync = button_pressed
	set_vsync_mode()

func _on_framerate_cap_item_selected(index: int) -> void:
	Config.set_value("graphics", "framerate_cap", index * 60)
	GlobalParameters.param_framerate_cap = index * 60
	set_fps()

func _on_mouse_lock_toggled(button_pressed: bool) -> void:
	Config.set_value("graphics", "mouse_locked", button_pressed)
	GlobalParameters.param_mouse_locked = button_pressed
	set_mouse_mode()


func _on_language_item_selected(index: int) -> void:
	Config.set_value("gameplay", "language", index)
	GlobalParameters.param_language = index

func _on_action_dice_count_toggled(button_pressed: bool) -> void:
	Config.set_value("gameplay", "action_dice_count", button_pressed)
	GlobalParameters.param_action_dice_count = button_pressed

func _on_music_when_paused_toggled(button_pressed: bool) -> void:
	Config.set_value("gameplay", "music_when_paused", button_pressed)
	GlobalParameters.param_music_when_paused = button_pressed


func _on_custom_rules_toggled(button_pressed: bool) -> void:
	Config.set_value("custom", "custom_rules_enabled", button_pressed)
	GlobalParameters.param_custom_rules_enabled = button_pressed

func _on_enemy_health_value_changed(value: float) -> void:
	Config.set_value("custom", "enemy_health", value)
	GlobalParameters.param_enemy_health = value

func _on_enemy_damage_value_changed(value: float) -> void:
	Config.set_value("custom", "enemy_damage", value)
	GlobalParameters.param_enemy_damage = value


func _on_back_button_pressed():
	@warning_ignore("return_value_discarded")
	emit_signal("exit_menu")
