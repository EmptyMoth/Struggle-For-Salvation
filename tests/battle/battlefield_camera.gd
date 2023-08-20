class_name BattlefieldCamera
extends Camera3D


const VIEWING_ANGLE_IS_NORMAL: float = -PI/6
const VIEWING_ANGLE_IS_COMBAT: float = -PI/18
const NORMAL_POSITION: Vector3 = Vector3(0, 6.0, 9)
const COMBAT_POSITION: Vector3 = Vector3(0, 2.5, 9)

var _drag: bool = false
var _cursor_loc: Vector2 = Vector2.ZERO

@onready var _animation: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	BattleSygnals.turn_started.connect(move_to_start_position)
	BattleSygnals.combat_started.connect(move_to_combat_position)
	_animation.play("move_camera")
	_animation.pause()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_camera_motion_control(event)

	if event is InputEventMouseMotion:
		_move_camera_by_player(event)


func move_to_start_position() -> void:
	_move_camera(VIEWING_ANGLE_IS_NORMAL, NORMAL_POSITION)

func move_to_combat_position() -> void:
	_move_camera(VIEWING_ANGLE_IS_COMBAT, COMBAT_POSITION)

func _move_camera(new_angle: float, new_position: Vector3) -> void:
	var tween: Tween = get_tree().create_tween().set_parallel()
	@warning_ignore("return_value_discarded")
	tween.tween_property(self, "rotation:x", new_angle, 1)
	@warning_ignore("return_value_discarded")
	tween.tween_property(self, "position", new_position, 1)


func _camera_motion_control(event_mouse_button: InputEventMouseButton) -> void:
	if event_mouse_button.button_index != MOUSE_BUTTON_MIDDLE:
		return
	
	_drag = not _drag
	if event_mouse_button.is_action_pressed("ui_mouse_button_middle"):
		_cursor_loc = event_mouse_button.position


func _move_camera_by_player(event_mouse_motion: InputEventMouseMotion) -> void:
	if not _drag:
		return
	
	var mouse_offset: Vector2 = _cursor_loc - event_mouse_motion.position
	#_set_new_position_by_x(mouse_offset)
	_animation.seek(_animation.current_animation_position + mouse_offset.y / 1080 / 1.5, true)
	_cursor_loc = event_mouse_motion.position


#func _set_new_position_by_x(mouse_offset: Vector2) -> void:
#	var new_position_by_x: float = position.x + mouse_offset.x / 4 / fov
#	position.x = clampf(new_position_by_x, -3.5, 3.5) 
