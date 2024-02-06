class_name BattleCamera
extends Camera2D


const _ZOOM_DURATION: float = 0.4
const _MOVE_DURATION: float = 0.4

@export_group("Zoom")
@export var can_change_zoom: bool = true
@export var _min_zoom: Vector2 = Vector2.ONE * 0.9
@export var _max_zoom: Vector2 = Vector2.ONE * 3
@export var _zoom_factor: Vector2 = Vector2.ONE * 0.03

@export_group("Movement")
@export var max_shift: Vector2 = Vector2(300, 0)


var _zoom_level: Vector2 = zoom :
	set(value):
		_zoom_level.x = clampf(value.x, _min_zoom.x, _max_zoom.x)
		_zoom_level.y = _zoom_level.x

var _cursor_lock_position: Vector2 = Vector2.ZERO
var _default_position = position
var _default_zoom = zoom


#func _process(_delta: float) -> void:
	#if zoom != _zoom_level:
		#zoom = zoom.lerp(_zoom_level, 0.09)
		#position = _adjust_position(position)


func player_moves_camera(event: InputEvent) -> void:
	_change_zoom(event)
	if event is InputEventMouse:
		_camera_motion_control(event)


func move_to_default_position() -> void:
	set_process(true)
	_zoom_level = _default_zoom
	_animate_movement(_default_position)
	_animate_zoom(_default_zoom)


func preparation_to_combat_position() -> void:
	set_process(false)


func move_to(new_position: Vector2, new_zoom: Vector2) -> void:
	new_position = _adjust_position(new_position)
	position = new_position
	zoom = zoom.lerp(new_zoom, 0.1)
	_animate_movement(new_position)
	_animate_zoom(new_zoom)


func _change_zoom(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_zoom_up") or Input.is_action_pressed("ui_zoom_up"):
		_zoom_level += _zoom_factor
	elif Input.is_action_just_pressed("ui_zoom_down") or Input.is_action_pressed("ui_zoom_down"):
		_zoom_level -= _zoom_factor
	else:
		return
	_animate_zoom(_zoom_level)


func _camera_motion_control(mouse_event: InputEventMouse) -> void:
	if Input.is_action_just_pressed("ui_player_move_camera"):
		_cursor_lock_position = mouse_event.position
	elif Input.is_action_pressed("ui_player_move_camera"):
		_move_camera(mouse_event)

func _move_camera(event_mouse_motion: InputEventMouse) -> void:
	var mouse_offset: Vector2 = _cursor_lock_position - event_mouse_motion.position
	var new_position: Vector2 = position + mouse_offset / zoom
	_cursor_lock_position = event_mouse_motion.position
	position = _adjust_position(new_position)


func _adjust_position(new_position: Vector2) -> Vector2:
	var current_max_shift: Vector2 = max_shift * zoom
	var max_position: Vector2 = _default_position + current_max_shift
	var min_position: Vector2 = _default_position - current_max_shift
	new_position.x = clampf(new_position.x, min_position.x, max_position.x)
	new_position.y = clampf(new_position.y, min_position.y, max_position.y)
	return new_position


func _animate_zoom(new_zoom: Vector2) -> void:
	get_tree().create_tween()\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUAD)\
		.tween_property(self, "zoom", new_zoom, 0.4)

func _animate_movement(new_position: Vector2) -> void:
	get_tree().create_tween()\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUAD)\
		.tween_property(self, "position", new_position, 0.4)
