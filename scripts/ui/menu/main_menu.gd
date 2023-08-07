extends Control


@onready var settings_menu: Control = $CenterContainer/SettingsMenu
@onready var menu: VBoxContainer = $CenterContainer/Menu


func _ready() -> void:
	settings_menu.hide()
	menu.show()


func _on_settings_menu_menu_exited() -> void:
	menu.show()
	settings_menu.hide()


func _on_settings_button_pressed() -> void:
	settings_menu.show()
	menu.hide()


func _on_exit_button_pressed() -> void:
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
