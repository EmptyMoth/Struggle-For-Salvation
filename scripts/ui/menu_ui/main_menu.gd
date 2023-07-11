extends Control


@onready var settings_menu: Control = $CenterContainer/SettingsMenu
@onready var menu: VBoxContainer = $CenterContainer/Menu


func _on_button_settings_pressed() -> void:
	settings_menu.show()
	menu.hide()


func _on_button_exit_pressed() -> void:
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_settings_menu_exit_menu() -> void:
	settings_menu.hide()
	menu.show()
