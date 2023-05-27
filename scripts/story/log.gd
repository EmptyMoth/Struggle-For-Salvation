class_name Log
extends MarginContainer


signal close_log


@onready var log_entries = $PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer


func _on_button_close_log_pressed():
	emit_signal("close_log")
