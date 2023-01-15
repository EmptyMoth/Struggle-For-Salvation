extends MarginContainer

signal close_log


func _on_button_close_log_pressed():
	emit_signal("close_log")
