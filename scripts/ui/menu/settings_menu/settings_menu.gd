class_name SettingsMenu
extends Control


signal menu_closed

@onready var settings: TabContainer = $CenterContainer/VBoxContainer/Panel/Margin/VBox/VBox/Content


func open_menu() -> void:
	show()


func close_menu() -> void:
	hide()


func _on_save_and_exit_button_pressed() -> void:
	Settings.save_settings()
	menu_closed.emit()


func _on_reset_button_pressed() -> void:
	var current_settings: SettingsList = settings.get_current_tab_control() as SettingsList
	current_settings.reset_settings()
