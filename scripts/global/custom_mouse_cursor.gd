extends Node


const _CURSOR_IMAGE_PATH: String = "res://sprites/global/custom_mouse_cursor/%s.png"
const _ARROW_IMAGE: Resource = preload(_CURSOR_IMAGE_PATH % "arrow")
const _PRESS_IMAGE: Resource = preload(_CURSOR_IMAGE_PATH % "press")
const _MOVE_IMAGE: Resource = preload(_CURSOR_IMAGE_PATH % "move")

static var _sound_event: SoundCommon

var _current_mouse_shape: Resource = _ARROW_IMAGE


func _init() -> void:
	_sound_event = SoundCommon.new(SoundEvents.UISoundID.MOUSE_CLICK)


func _ready() -> void:
	Input.set_custom_mouse_cursor(_ARROW_IMAGE, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(_PRESS_IMAGE, Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(_MOVE_IMAGE, Input.CURSOR_MOVE)


func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return

	var new_cursor_shape: Resource = _get_cursor_shape_by_action(event)
	_set_cursor_shape(new_cursor_shape)
	if Input.is_action_just_pressed("ui_pick"):
		_sound_event.play()


func _set_cursor_shape(new_cursor_shape: Resource) -> void:
	if _current_mouse_shape != new_cursor_shape:
		_current_mouse_shape = new_cursor_shape
		Input.set_custom_mouse_cursor(new_cursor_shape)


func _get_cursor_shape_by_action(mouse_event: InputEventMouseButton) -> Resource:
	if not mouse_event.pressed:
		return _ARROW_IMAGE
	
	match mouse_event.button_index:
		MOUSE_BUTTON_LEFT: return _PRESS_IMAGE
		MOUSE_BUTTON_MIDDLE: return _MOVE_IMAGE
		_: return _ARROW_IMAGE
