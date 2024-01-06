class_name MainMenu
extends Control


@onready var _settings_menu: SettingsMenu = $SettingsMenu
@onready var _location_texture: TextureRect = $LastLocation/Location
@onready var _main_shadow: ColorRect = $MainShadow


func _ready() -> void:
	_settings_menu.close_menu()
	_set_last_location()


func _set_last_location() -> void:
	var last_location: GlobalEnums.Locations = GlobalEnums.Locations.values().pick_random()
	var location_name: String = GlobalEnums.Locations.find_key(last_location).to_lower()
	location_name = GlobalParameters.FOLDER_WITH_LOCATION_TEXTURE + location_name + ".png"
	var texture: CompressedTexture2D = load(location_name)
	_location_texture.texture = texture


func _on_settings_menu_closed() -> void:
	_main_shadow.mouse_filter = Control.MOUSE_FILTER_IGNORE
	await get_tree().create_tween().tween_property(_main_shadow, "modulate:a", 0, 0.3).finished


func _on_settings_button_pressed() -> void:
	_settings_menu.open_menu()
	_main_shadow.mouse_filter = Control.MOUSE_FILTER_STOP
	get_tree().create_tween().tween_property(_main_shadow, "modulate:a", 0.8, 0.3)


func _on_exit_button_pressed() -> void: GlobalParameters.exit_game()
