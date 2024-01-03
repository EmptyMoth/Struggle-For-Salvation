class_name PlayerCamera2D
extends Camera2D


enum CameraDirections { NOT_MOVE, MOVE_BY_X, MOVE_BY_Y, MOVE_BY_X_AND_Y }

const _ZOOM_DURATION: float = 0.4
const _MOVE_DURATION: float = 0.4

@export_group("Zoom")
@export var can_change_zoom: bool = true
@export var _min_zoom: Vector2 = Vector2.ONE * 0.9
@export var _max_zoom: Vector2 = Vector2.ONE * 3
@export var _zoom_factor: Vector2 = Vector2.ONE * 0.03

@export_group("Movement")
@export var camera_direction: CameraDirections = CameraDirections.MOVE_BY_X_AND_Y
@export var max_shift: Vector2 = Vector2(960, 540)


var _zoom_level: Vector2 = zoom :
	set(value):
		_zoom_level.x = clampf(value.x, _min_zoom.x, _max_zoom.x)
		_zoom_level.y = clampf(value.y, _min_zoom.y, _max_zoom.y)

var _on_drag: bool = false
var _cursor_lock_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	limit_left = -1.5 * get_viewport().size.x
	limit_right = 1.5 * get_viewport().size.x
	limit_top = -1.5 * get_viewport().size.y
	limit_bottom = 1.5 * get_viewport().size.y


func _input(event: InputEvent) -> void:
	if can_change_zoom:
		if event is InputEventMouseButton:
			_change_zoom(event)
	
	if camera_direction != CameraDirections.NOT_MOVE:
		if event is InputEventMouseButton:
			_camera_motion_control(event)
		if event is InputEventMouseMotion:
			_move_camera(event)


func _camera_motion_control(event_mouse_button: InputEventMouseButton) -> void:
	if event_mouse_button.button_index != MOUSE_BUTTON_MIDDLE:
		return
	
	_on_drag = not _on_drag
	if event_mouse_button.is_action_pressed("ui_mouse_button_middle"):
		_cursor_lock_position = event_mouse_button.position


func _move_camera(event_mouse_motion: InputEventMouseMotion) -> void:
	if camera_direction == CameraDirections.NOT_MOVE or not _on_drag:
		return
	
	var mouse_offset: Vector2 = _cursor_lock_position - event_mouse_motion.position
	var new_position: Vector2 = position + mouse_offset / zoom
	match camera_direction:
		CameraDirections.MOVE_BY_X_AND_Y:
			position.x = clampf(new_position.x, -max_shift.x, max_shift.x)
			position.y = clampf(new_position.y, -max_shift.y, max_shift.y)
		CameraDirections.MOVE_BY_X:
			position.x = clampf(new_position.x, -max_shift.x, max_shift.x)
		CameraDirections.MOVE_BY_Y:
			position.y = clampf(new_position.y, -max_shift.y, max_shift.y)
	
	_cursor_lock_position = event_mouse_motion.position


func _change_zoom(event_mouse_button: InputEventMouseButton) -> void:
	if event_mouse_button.is_action("ui_scroll_up"):
		_zoom_level += _zoom_factor
	elif event_mouse_button.is_action("ui_scroll_down"):
		_zoom_level -= _zoom_factor
	else:
		return
	
	_animate_zoom_change(_zoom_level)


func _animate_zoom_change(new_zoom: Vector2) -> void:
	get_tree().create_tween()\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)\
		.tween_property(self, "zoom", new_zoom, _ZOOM_DURATION)


func zoom_to(new_position: Vector2, new_zoom: Vector2) -> void:
	new_position -= Vector2(get_viewport().size / 2)
	match camera_direction:
		CameraDirections.MOVE_BY_X_AND_Y:
			new_position.x = clampf(new_position.x, -max_shift.x, max_shift.x)
			new_position.y = clampf(new_position.y, -max_shift.y, max_shift.y)
		CameraDirections.MOVE_BY_X:
			new_position.x = clampf(new_position.x, -max_shift.x, max_shift.x)
		CameraDirections.MOVE_BY_Y:
			new_position.y = clampf(new_position.y, -max_shift.y, max_shift.y)
	
	_zoom_level = new_zoom
	get_tree().create_tween().tween_property(self, "position", new_position, _MOVE_DURATION)
	_animate_zoom_change(_zoom_level)
