extends Control


var menu_pause: CenterContainer
var menu_settings: Control


func _ready():
	menu_pause = $Margins/MenuPause
	menu_settings = $Margins/MenuSettings


func pause_game() -> void:
	get_tree().paused = true
	visible = true


func close_menu() -> void:
	get_tree().paused = false
	visible = false


func _on_button_continue_pressed() -> void:
	close_menu()


func _on_button_manual_pressed():
	pass # Replace with function body.


func _on_button_settings_pressed() -> void:
	menu_pause.hide()
	menu_settings.show()


func _on_menu_settings_exit_menu() -> void:
	menu_pause.show()
	menu_settings.hide()


func _on_button_level_select_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/menu_ui/level_select/menu_level_select.tscn")


func _on_button_main_menu_pressed() -> void:
	get_tree().paused = false
	@warning_ignore("return_value_discarded")
	get_tree().change_scene_to_file("res://scenes/ui/menu_ui/main_menu.tscn")


func _on_button_exit_pressed() -> void:
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
