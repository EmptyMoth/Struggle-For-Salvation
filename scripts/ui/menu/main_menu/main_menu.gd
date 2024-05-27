class_name MainMenu
extends Control


@onready var _settings_menu: SettingsMenu = $SettingsMenu
@onready var _location_texture: TextureRect = $LastLocation/Location
@onready var _main_shadow: ColorRect = $MainShadow


func _ready() -> void:
	MainMenuButton.button_group.pressed.connect(_on_button_group_pressed)
	_settings_menu.close_menu()
	_set_last_location()
	$Main/Menu/PlayButton.to_press()
	($Main/Menu/PlayButton/Margin/Button as Button).set_pressed_no_signal(true)
	await get_tree().process_frame
	_on_button_group_pressed($Main/Menu/PlayButton/Margin/Button)


func _set_last_location() -> void:
	var last_location: GlobalEnums.Locations = GlobalEnums.Locations.values().pick_random()
	var location_name: String = GlobalEnums.Locations.find_key(last_location).to_lower()
	location_name = GlobalParameters.FOLDER_WITH_LOCATION_TEXTURE + location_name + ".png"
	var texture: CompressedTexture2D = load(location_name)
	_location_texture.texture = texture


func _on_button_group_pressed(button: BaseButton) -> void:
	var next_y_position: float = button.get_global_rect().get_center().y
	var different_position_by_y: float = next_y_position - $TextureRect.global_position.y
	var length_percent: float = different_position_by_y / $TextureRect.size.x
	$TextureRect2.global_position.y = next_y_position - $TextureRect2.size.y
	
	var gradient: Gradient = ($TextureRect.texture as GradientTexture1D).gradient
	var not_accent_color: Color = gradient.get_color(2)
	var accent_color: Color = gradient.get_color(3)
	gradient.remove_point(5)
	gradient.remove_point(4)
	gradient.remove_point(3)
	gradient.remove_point(2)
	gradient.add_point(length_percent - 0.12, not_accent_color)
	gradient.add_point(length_percent - 0.02, accent_color)
	gradient.add_point(length_percent + 0.02, accent_color)
	gradient.add_point(length_percent + 0.12, not_accent_color)


func _on_settings_menu_closed() -> void:
	_main_shadow.mouse_filter = Control.MOUSE_FILTER_IGNORE
	await get_tree().create_tween().tween_property(_main_shadow, "modulate:a", 0, 0.3).finished


func _on_settings_button_pressed() -> void:
	_settings_menu.open_menu()
	_main_shadow.mouse_filter = Control.MOUSE_FILTER_STOP
	get_tree().create_tween().tween_property(_main_shadow, "modulate:a", 0.8, 0.3)


func _on_exit_button_pressed() -> void:
	GlobalParameters.exit_game()


func _on_play_button_pressed() -> void:
	GlobalParameters.change_scene_with_transition("res://tests/battle/test_battle.tscn")
