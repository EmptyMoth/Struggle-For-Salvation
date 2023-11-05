@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("SmoothScrollContainer", "ScrollContainer", preload("smooth_scroll_container.gd"), preload("class-icon.svg"))


func _exit_tree():
	remove_custom_type("SmoothScrollContainer")
