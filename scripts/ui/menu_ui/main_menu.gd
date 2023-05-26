extends Control


var menu_settings: Control
var menu: VBoxContainer


func _ready() -> void:
	menu_settings = $CenterContainer/MenuSettings
	menu = $CenterContainer/Menu


func _on_button_settings_pressed() -> void:
	menu_settings.show()
	menu.hide()


func _on_button_exit_pressed() -> void:
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_menu_settings_exit_menu() -> void:
	menu_settings.hide()
	menu.show()
