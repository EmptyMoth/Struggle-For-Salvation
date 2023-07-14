extends Camera3D


enum CameraDirections { NOT_MOVE, MOVE_BY_X, MOVE_BY_Y, MOVE_BY_X_AND_Y }

@export var can_change_zoom: bool = true
@export var camera_direction: CameraDirections = CameraDirections.NOT_MOVE
@export var max_shift: Vector2 = Vector2(960, 540)

#const _MIN_ZOOM: Vector2 = Vector2.ONE * 0.9
#const _MAX_ZOOM: Vector2 = Vector2.ONE * 3
#const _ZOOM_FACTOR: Vector2 = Vector2.ONE * 0.03
#const _ZOOM_DURATION: float = 0.4
#
#var _zoom_level: Vector2 = zoom :
#	set(value):
#		_zoom_level = clamp(value, _MIN_ZOOM, _MAX_ZOOM)

var _drag: bool = false
var _cursor_loc: Vector2 = Vector2.ZERO


func _input(event: InputEvent) -> void:
#	if can_change_zoom:
#		if event is InputEventMouseButton:
#			_change_zoom(event)
	
	if camera_direction != CameraDirections.NOT_MOVE:
		if event is InputEventMouseButton:
			_camera_motion_control(event)
		if event is InputEventMouseMotion:
			_move_camera(event)


func _camera_motion_control(event_mouse_button: InputEventMouseButton) -> void:
	if event_mouse_button.button_index != MOUSE_BUTTON_MIDDLE:
		return

	_drag = not _drag
	if event_mouse_button.is_action_pressed("ui_mouse_button_middle"):
		_cursor_loc = event_mouse_button.position


func _move_camera(event_mouse_motion: InputEventMouseMotion) -> void:
	if not _drag:
		return
	
	var mouse_offset: Vector2 = _cursor_loc - event_mouse_motion.position
	var new_position: Vector2 = Vector2(position.x, position.y) + mouse_offset / far
	match camera_direction:
		CameraDirections.MOVE_BY_X_AND_Y:
			position = clamp(new_position, -max_shift, max_shift)
		CameraDirections.MOVE_BY_X:
			position.x = clampf(new_position.x, -max_shift.x, max_shift.x)
		CameraDirections.MOVE_BY_Y:
			position.y = clampf(new_position.y, -max_shift.y, max_shift.y)
	
	_cursor_loc = event_mouse_motion.position


#func _change_zoom(event_mouse_button: InputEventMouseButton) -> void:
#	if event_mouse_button.is_action("ui_mouse_button_wheel_up"):
#		_zoom_level += _ZOOM_FACTOR
#	elif event_mouse_button.is_action("ui_mouse_button_wheel_down"):
#		_zoom_level -= _ZOOM_FACTOR
#	else:
#		return
#
#	_animate_zoom_change(_zoom_level)
#
#
#func _animate_zoom_change(new_zoom: Vector2) -> void:
#	var tween: Tween = get_tree().create_tween()
#	@warning_ignore("return_value_discarded")
#	tween.tween_property(self, "zoom", new_zoom, _ZOOM_DURATION)\
#		.set_trans(Tween.TRANS_EXPO)\
#		.set_ease(Tween.EASE_OUT)

