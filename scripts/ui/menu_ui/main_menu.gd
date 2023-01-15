extends Control


var menu_settings: Control
var menu: VBoxContainer


func _ready():
	@warning_ignore(return_value_discarded)
	Config.validate_config()
	menu_settings = $CenterContainer/MenuSettings
	menu = $CenterContainer/Menu


func _on_button_settings_pressed() -> void:
	menu_settings.show()
	menu.hide()


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_menu_settings_exit_menu() -> void:
	menu_settings.hide()
	menu.show()
