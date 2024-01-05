class_name SettingsMenu
extends Control


signal menu_exited


@onready var settings: TabContainer = $CenterContainer/VBoxContainer/Panel/Margin/VBox/VBox/Content


func _on_save_and_exit_button_pressed() -> void:
	Settings.save_settings()
	emit_signal("menu_exited")


func _on_reset_button_pressed() -> void:
	var current_settings: SettingsList = settings.get_current_tab_control() as SettingsList
	current_settings.reset_settings()
