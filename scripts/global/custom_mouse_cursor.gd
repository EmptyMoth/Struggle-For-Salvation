extends Node


const CURSOR_IMAGE_PATH: String = "res://sprites/global/custom_mouse_cursor/%s.png"
const ARROW_IMAGE: Resource = preload(CURSOR_IMAGE_PATH % "arrow")
const PRESS_IMAGE: Resource = preload(CURSOR_IMAGE_PATH % "press")
const MOVE_IMAGE: Resource = preload(CURSOR_IMAGE_PATH % "move")

var _current_mouse_shape: Resource = ARROW_IMAGE


func _ready() -> void:
	Input.set_custom_mouse_cursor(ARROW_IMAGE, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(PRESS_IMAGE, Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(MOVE_IMAGE, Input.CURSOR_MOVE)


func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return

	var new_cursor_shape: Resource = _get_cursor_shape_by_action(event)
	_set_cursor_shape(new_cursor_shape)


func _set_cursor_shape(new_cursor_shape: Resource) -> void:
	if _current_mouse_shape != new_cursor_shape:
		_current_mouse_shape = new_cursor_shape
		Input.set_custom_mouse_cursor(new_cursor_shape)


func _get_cursor_shape_by_action(mouse_event: InputEventMouseButton) -> Resource:
	if not mouse_event.pressed:
		return ARROW_IMAGE
	
	match mouse_event.button_index:
		MOUSE_BUTTON_LEFT:
			return PRESS_IMAGE
		MOUSE_BUTTON_MIDDLE:
			return MOVE_IMAGE
	return ARROW_IMAGE
