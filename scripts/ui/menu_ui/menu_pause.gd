extends Control


func _ready():
	pass#get_tree().paused = true


func pause_game() -> void:
	get_tree().paused = true
	visible = true

func close_menu() -> void:
	get_tree().paused = false
	visible = false
	#queue_free()

func _on_button_continue_pressed() -> void:
	close_menu()

func _on_button_manual_pressed():
	pass # Replace with function body.

func _on_button_settings_pressed() -> void:
	$Margins/MenuPause.visible = false
	$Margins/MenuSettings.visible = true

func _on_menu_settings_exit_menu() -> void:
	$Margins/MenuPause.visible = true
	$Margins/MenuSettings.visible = false

func _on_button_level_select_pressed() -> void:
	pass # Replace with function body.

func _on_button_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/menu_ui/main_menu.tscn")
