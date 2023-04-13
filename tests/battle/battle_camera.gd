class_name BattleCamera
extends Camera2D


const _MIN_ZOOM: Vector2 = Vector2.ONE * 0.9
const _MAX_ZOOM: Vector2 = Vector2.ONE * 3
const _ZOOM_FACTOR: Vector2 = Vector2.ONE * 0.03
const _ZOOM_DURATION: float = 0.4

var _zoom_level: Vector2 = zoom :
	set(value):
		_zoom_level = clamp(value, _MIN_ZOOM, _MAX_ZOOM)
		_animate_zoom_change(_zoom_level)

var _drag: bool = false
var _cursor_loc: Vector2 = Vector2.ZERO


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_change_zoom(event)
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
	if _drag:
		var offset_position: Vector2 = (_cursor_loc - event_mouse_motion.position) / 2
		position += offset_position / zoom
		_cursor_loc = event_mouse_motion.position


func _change_zoom(event_mouse_button: InputEventMouseButton) -> void:
	if event_mouse_button.is_action("ui_mouse_button_wheel_up"):
		_zoom_level += _ZOOM_FACTOR
	elif event_mouse_button.is_action("ui_mouse_button_wheel_down"):
		_zoom_level -= _ZOOM_FACTOR


func _animate_zoom_change(new_zoom: Vector2) -> void:
	var tween: Tween = get_tree().create_tween()
	@warning_ignore("return_value_discarded")
	tween.tween_property(self, "zoom", new_zoom, _ZOOM_DURATION)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
