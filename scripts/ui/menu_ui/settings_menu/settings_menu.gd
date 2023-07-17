class_name SettingsMenu
extends Control


signal menu_exited


func _on_save_and_exit_button_pressed() -> void:
	Settings.save_settings()
	emit_signal("menu_exited")
