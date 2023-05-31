extends Control


signal exit_menu

var resolution_option_button: OptionButton


func _ready() -> void:
	init()

func init() -> void:
	var path: HBoxContainer = $MenuSettings/VBoxContainer/HBoxContainer
	var settings: VBoxContainer = path.get_node("SettingsGameplay")
	settings.get_node("Language/OptionButton").selected = Settings.language
	settings.get_node("ActionDice/CheckButton").button_pressed = Settings.action_dice_count
	settings.get_node("MusicWhenPaused/CheckButton").button_pressed = Settings.music_when_paused
	
	settings.get_node("CustomRules/CheckButton").button_pressed = Settings.custom_rules_enabled
	settings.get_node("EnemyHealth/HSlider").value = Settings.enemy_health
	settings.get_node("EnemyDamage/HSlider").value = Settings.enemy_damage
	
	settings = path.get_node("SettingsSound")
	settings.get_node("VolumeMaster/HSlider").value = Settings.volume_master
	settings.get_node("VolumeMusic/HSlider").value = Settings.volume_music
	settings.get_node("VolumeEffects/HSlider").value = Settings.volume_effects
	
	settings = path.get_node("SettingsGraphics")
	settings.get_node("Display/OptionButton").selected = Settings.display
	settings.get_node("TextureQuality/OptionButton").selected = Settings.texture_quality
	settings.get_node("Vsync/CheckButton").button_pressed = Settings.vsync
	settings.get_node("FramerateCap/OptionButton").selected = Settings.framerate_cap / Settings.FPS_MULTIPLIER
	settings.get_node("MouseLock/CheckButton").button_pressed = Settings.mouse_locked
	
	resolution_option_button = settings.get_node("Resolution/OptionButton")
	add_resolutions()


func add_resolutions() -> void:
	var index = 0
	
	for res in Settings.Resolutions:
		resolution_option_button.add_item(res, index)
		
		if Settings.Resolutions[res] == Settings.Resolutions[Settings.resolution]:
			resolution_option_button._select_int(index)
		
		index += 1


func _on_volume_master_value_changed(value: int) -> void:
	Settings.volume_master = value

func _on_volume_music_value_changed(value: int) -> void:
	Settings.volume_music = value

func _on_volume_effects_value_changed(value: int) -> void:
	Settings.volume_effects = value


func _on_resolution_item_selected(index: int) -> void:
	Settings.resolution = resolution_option_button.get_item_text(index)
	Settings.apply_display_mode()
	Settings.apply_resolution()

func _on_display_item_selected(index: int) -> void:
	Settings.display = index as Settings.Display
	Settings.apply_display_mode()
	Settings.apply_resolution()

func _on_texture_quality_item_selected(index: int) -> void:
	Settings.texture_quality = index as Settings.Quality

func _on_vsync_toggled(button_pressed: bool) -> void:
	Settings.vsync = button_pressed
	Settings.apply_vsync_mode()

func _on_framerate_cap_item_selected(index: int) -> void:
	Settings.framerate_cap = index * Settings.FPS_MULTIPLIER
	Settings.apply_fps()

func _on_mouse_lock_toggled(button_pressed: bool) -> void:
	Settings.mouse_locked = button_pressed
	Settings.apply_mouse_mode()


func _on_language_item_selected(index: int) -> void:
	Settings.language = index

func _on_action_dice_count_toggled(button_pressed: bool) -> void:
	Settings.action_dice_count = button_pressed

func _on_music_when_paused_toggled(button_pressed: bool) -> void:
	Settings.music_when_paused = button_pressed


func _on_custom_rules_toggled(button_pressed: bool) -> void:
	Settings.custom_rules_enabled = button_pressed

func _on_enemy_health_value_changed(value: float) -> void:
	Settings.enemy_health = value

func _on_enemy_damage_value_changed(value: float) -> void:
	Settings.enemy_damage = value


func _on_back_button_pressed():
	Settings.save_settings()
	
	@warning_ignore("return_value_discarded")
	emit_signal("exit_menu")
