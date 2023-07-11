class_name SettingsMenu
extends Control


func _on_button_pressed() -> void:
	Settings.save_settings()
