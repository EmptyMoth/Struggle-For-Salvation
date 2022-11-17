extends Control


func _ready():
	Config.validate_config()


func _on_button_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://tests/battle/test_battle_2d.tscn")

func _on_button_settings_pressed() -> void:
	$CenterContainer/MenuSettings.visible = true
	$CenterContainer/Menu.visible = false

func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_menu_settings_exit_menu() -> void:
	$CenterContainer/MenuSettings.visible = false
	$CenterContainer/Menu.visible = true
