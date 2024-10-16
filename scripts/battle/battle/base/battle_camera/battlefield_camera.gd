class_name BattlefieldCamera
extends Camera3D

const _MOVE_DURATION: float = 0.2

const VIEWING_ANGLE_IS_NORMAL: float = -PI/6
const VIEWING_ANGLE_IS_COMBAT: float = -PI/18/2

const MAX_POSITION: Vector3 = Vector3(0, 7.0, 9)
const DEFAULT_POSITION: Vector3 = Vector3(0, 6.0, 9)
const MIN_POSITION: Vector3 = Vector3(0, 5.5, 9)
const END_ROTAION_POSITION: Vector3 = Vector3(0, 2, 9)

var _drag: bool = false
var _cursor_lock_position: Vector2 = Vector2.ZERO
var camera_position_fraction: float = 0.3


func player_moves_camera(event: InputEvent) -> void:
	if not event is InputEventMouse:
		return
	if Input.is_action_just_pressed("ui_player_move_camera"):
		_cursor_lock_position = event.position
	elif Input.is_action_pressed("ui_player_move_camera") and event is InputEventMouseMotion:
		_move_camera_by_player(event)


func move_to_default_position() -> void:
	_move_camera(VIEWING_ANGLE_IS_NORMAL, DEFAULT_POSITION, 1)

func move_to_combat_position() -> void:
	_move_camera(VIEWING_ANGLE_IS_COMBAT, END_ROTAION_POSITION, 1)


func _move_camera(new_angle: float, new_position: Vector3, duration: float) -> void:
	var tween: Tween = get_tree().create_tween().set_parallel()
	tween.tween_property(self, "rotation:x", new_angle, duration)
	tween.tween_property(self, "position", new_position, duration)


func _move_camera_by_player(event_mouse_motion: InputEventMouseMotion) -> void:
	var mouse_offset: Vector2 = _cursor_lock_position - event_mouse_motion.global_position
	_cursor_lock_position = event_mouse_motion.global_position
	var animation_offset: float = mouse_offset.y / DisplayServer.window_get_size().y * 1.5
	camera_position_fraction = clampf(camera_position_fraction - animation_offset, 0, 1)
	var new_position: Vector3 = position
	if camera_position_fraction <= 0.6:
		new_position.y = lerpf(MIN_POSITION.y, MAX_POSITION.y, camera_position_fraction / 0.6)
	else:
		new_position.y = lerpf(MAX_POSITION.y, END_ROTAION_POSITION.y, (camera_position_fraction - 0.6) / 0.4)
	var rotation_fraction: float = clampf((camera_position_fraction - 0.6) / 0.4, 0, 1)
	var new_angle: float = lerp_angle(VIEWING_ANGLE_IS_NORMAL, VIEWING_ANGLE_IS_COMBAT, rotation_fraction)
	_move_camera(new_angle, new_position, _MOVE_DURATION)
