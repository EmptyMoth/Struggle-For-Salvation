extends Control


signal exit_menu


func _ready() -> void:
	init()

func init() -> void:
	@warning_ignore("return_value_discarded")
	if(!Settings.param_init):
		Config.validate_config()
	
	var path: HBoxContainer = $MenuSettings/VBoxContainer/HBoxContainer
	var settings: VBoxContainer = path.get_node("SettingsGameplay")
	settings.get_node("Language/OptionButton").selected = Settings.param_language
	settings.get_node("ActionDice/CheckButton").button_pressed = Settings.param_action_dice_count
	settings.get_node("MusicWhenPaused/CheckButton").button_pressed = Settings.param_music_when_paused
	
	settings.get_node("CustomRules/CheckButton").button_pressed = Settings.param_custom_rules_enabled
	settings.get_node("EnemyHealth/HSlider").value = Settings.param_enemy_health
	settings.get_node("EnemyDamage/HSlider").value = Settings.param_enemy_damage
	
	settings = path.get_node("SettingsSound")
	settings.get_node("VolumeMaster/HSlider").value = Settings.param_volume_master
	settings.get_node("VolumeMusic/HSlider").value = Settings.param_volume_music
	settings.get_node("VolumeEffects/HSlider").value = Settings.param_volume_effects
	
	settings = path.get_node("SettingsGraphics")
	settings.get_node("Resolution/OptionButton").selected = Settings.param_resolution
	settings.get_node("Display/OptionButton").selected = Settings.param_display
	settings.get_node("TextureQuality/OptionButton").selected = Settings.param_texture_quality
	settings.get_node("Vsync/CheckButton").button_pressed = Settings.param_vsync
	settings.get_node("FramerateCap/OptionButton").selected = Settings.param_framerate_cap / 60
	settings.get_node("MouseLock/CheckButton").button_pressed = Settings.param_mouse_locked
	
	set_display_mode()
	set_resolution()
	set_mouse_mode()
	set_vsync_mode()
	set_fps()


func set_resolution() -> void:
	get_viewport().size = Settings.get_resolution()
	DisplayServer.window_set_size(Settings.get_resolution())

func set_display_mode() -> void:
	var display_mode = Settings.param_display
	
	if(display_mode == Settings.Display.DISPLAY_BORDERLESS):
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	
	DisplayServer.window_set_mode(Settings.get_display_mode(display_mode))

func set_mouse_mode() -> void:
	if(Settings.param_mouse_locked):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CONFINED)
	else:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)

func set_vsync_mode() -> void:
	if(Settings.param_vsync):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func set_fps() -> void:
	ProjectSettings.set_setting("application/run/max_fps", Settings.param_framerate_cap)


func _on_volume_master_value_changed(value: int) -> void:
	Settings.param_volume_master = value

func _on_volume_music_value_changed(value: int) -> void:
	Settings.param_volume_music = value

func _on_volume_effects_value_changed(value: int) -> void:
	Settings.param_volume_effects = value


func _on_resolution_item_selected(index: int) -> void:
	Settings.param_resolution = index as Settings.ResolutionIndex
	set_display_mode()
	set_resolution()

func _on_display_item_selected(index: int) -> void:
	Settings.param_display = index as Settings.Display
	set_display_mode()
	set_resolution()

func _on_texture_quality_item_selected(index: int) -> void:
	Settings.param_texture_quality = index as Settings.Quality

func _on_vsync_toggled(button_pressed: bool) -> void:
	Settings.param_vsync = button_pressed
	set_vsync_mode()

func _on_framerate_cap_item_selected(index: int) -> void:
	Settings.param_framerate_cap = index * 60
	set_fps()

func _on_mouse_lock_toggled(button_pressed: bool) -> void:
	Settings.param_mouse_locked = button_pressed
	set_mouse_mode()


func _on_language_item_selected(index: int) -> void:
	Settings.param_language = index

func _on_action_dice_count_toggled(button_pressed: bool) -> void:
	Settings.param_action_dice_count = button_pressed

func _on_music_when_paused_toggled(button_pressed: bool) -> void:
	Settings.param_music_when_paused = button_pressed


func _on_custom_rules_toggled(button_pressed: bool) -> void:
	Settings.param_custom_rules_enabled = button_pressed

func _on_enemy_health_value_changed(value: float) -> void:
	Settings.param_enemy_health = value

func _on_enemy_damage_value_changed(value: float) -> void:
	Settings.param_enemy_damage = value


func _on_back_button_pressed():
	Config.save_config()
	
	@warning_ignore("return_value_discarded")
	emit_signal("exit_menu")
