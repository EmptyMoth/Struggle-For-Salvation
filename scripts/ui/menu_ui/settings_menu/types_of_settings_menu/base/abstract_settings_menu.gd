class_name AbstractSettingsMenu
extends MarginContainer


var _settings_server: AbstractSettingsType


func _on_reset_button_pressed() -> void:
	_settings_server.set_default_settings()
