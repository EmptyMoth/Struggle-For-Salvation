class_name SettingsMenu
extends Control


signal menu_exited


func _ready() -> void:
	var tab_container: TabContainer = $CenterContainer/VBoxContainer/TabContainer
	for tab_index in tab_container.get_tab_count():
		var settings: AbstractSettingsMenu = tab_container.get_child(tab_index)
		tab_container.set_tab_title(tab_index, settings.settings_group_name)


func _on_save_and_exit_button_pressed() -> void:
	Settings.save_settings()
	emit_signal("menu_exited")
