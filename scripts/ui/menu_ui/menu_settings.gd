extends Control


signal exit_menu


func _ready() -> void:
	init()

func init() -> void:
	Config.validate_config()
	
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGameplay/Language/OptionButton.selected = Config.get_value("gameplay", "language")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGameplay/ActionDice/CheckButton.button_pressed = Config.get_value("gameplay", "action_dice_count")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGameplay/MusicWhenPaused/CheckButton.button_pressed = Config.get_value("gameplay", "music_when_paused")
	
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGameplay/CustomRules/CheckButton.button_pressed = Config.get_value("custom", "custom_rules_enabled")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGameplay/EnemyHealth/HSlider.value = Config.get_value("custom", "enemy_health")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGameplay/EnemyDamage/HSlider.value = Config.get_value("custom", "enemy_damage")
	
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsSound/VolumeMaster/HSlider.value = Config.get_value("sound", "volume_master")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsSound/VolumeMusic/HSlider.value = Config.get_value("sound", "volume_music")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsSound/VolumeEffects/HSlider.value = Config.get_value("sound", "volume_effects")
	
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGraphics/Resolution/OptionButton.selected = Config.get_value("graphics", "resolution")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGraphics/Display/OptionButton.selected = Config.get_value("graphics", "display")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGraphics/TextureQuality/OptionButton.selected = Config.get_value("graphics", "texture_quality")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGraphics/Vsync/CheckButton.button_pressed = Config.get_value("graphics", "vsync")
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGraphics/FramerateCap/OptionButton.selected = Config.get_value("graphics", "framerate_cap") / 60
	$MenuSettings/VBoxContainer/HBoxContainer/SettingsGraphics/MouseLock/CheckButton.button_pressed = Config.get_value("graphics", "mouse_locked")
	
	set_display_mode()
	set_resolution()
	set_mouse_mode()
	set_vsync_mode()
	set_fps()


func set_resolution() -> void:
	match Config.get_value("graphics", "display"):
		Config.Display.DISPLAY_WINDOWED:
			get_viewport().size = Config.get_resolution()
			DisplayServer.window_set_size(Config.get_resolution())
		Config.Display.DISPLAY_BORDERLESS:
			get_viewport().size = Config.get_resolution()
			DisplayServer.window_set_size(Config.get_resolution())
			#DisplayServer.window_set_size(DisplayServer.screen_get_size())
			#DisplayServer.window_set_position(Vector2i(0, 0))
		Config.Display.DISPLAY_FULLSCREEN:
			get_viewport().size = Config.get_resolution()
			#DisplayServer.window_set_size(get_resolution(config.get_value("graphics", "resolution")))

func set_display_mode() -> void:
	var display_mode = Config.get_value("graphics", "display")
	
	if(display_mode == Config.Display.DISPLAY_BORDERLESS):
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	
	DisplayServer.window_set_mode(Config.get_display_mode(display_mode))

func set_mouse_mode() -> void:
	if(Config.get_value("graphics", "mouse_locked")):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CONFINED)
	else:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)

func set_vsync_mode() -> void:
	if(Config.get_value("graphics", "vsync")):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func set_fps() -> void:
	ProjectSettings.set_setting("application/run/max_fps", Config.get_value("graphics", "framerate_cap"))


func _on_volume_master_value_changed(value: int) -> void:
	Config.set_value("sound", "volume_master", value)

func _on_volume_music_value_changed(value: int) -> void:
	Config.set_value("sound", "volume_music", value)

func _on_volume_effects_value_changed(value: int) -> void:
	Config.set_value("sound", "volume_effects", value)


func _on_resolution_item_selected(index: int) -> void:
	Config.set_value("graphics", "resolution", index)
	set_display_mode()
	set_resolution()

func _on_display_item_selected(index: int) -> void:
	Config.set_value("graphics", "display", index)
	set_display_mode()
	set_resolution()

func _on_texture_quality_item_selected(index: int) -> void:
	Config.set_value("graphics", "texture_quality", index)

func _on_vsync_toggled(button_pressed: bool) -> void:
	Config.set_value("graphics", "vsync", button_pressed)
	set_vsync_mode()

func _on_framerate_cap_item_selected(index: int) -> void:
	Config.set_value("graphics", "framerate_cap", index*60)
	set_fps()

func _on_mouse_lock_toggled(button_pressed: bool) -> void:
	Config.set_value("graphics", "mouse_locked", button_pressed)
	set_mouse_mode()


func _on_language_item_selected(index: int) -> void:
	Config.set_value("gameplay", "language", index)

func _on_action_dice_count_toggled(button_pressed: bool) -> void:
	Config.set_value("gameplay", "action_dice_count", button_pressed)

func _on_music_when_paused_toggled(button_pressed: bool) -> void:
	Config.set_value("gameplay", "music_when_paused", button_pressed)


func _on_custom_rules_toggled(button_pressed: bool) -> void:
	Config.set_value("custom", "custom_rules_enabled", button_pressed)

func _on_enemy_health_value_changed(value: float) -> void:
	Config.set_value("custom", "enemy_health", value)

func _on_enemy_damage_value_changed(value: float) -> void:
	Config.set_value("custom", "enemy_damage", value)


func _on_back_button_pressed():
	emit_signal("exit_menu")
