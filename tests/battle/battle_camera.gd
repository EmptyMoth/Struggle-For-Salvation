extends Camera2D


@export var min_zoom := Vector2(0.9, 0.9)
@export var max_zoom := Vector2(3, 3)
@export var zoom_factor := Vector2(0.05, 0.05)
@export var zoom_duration := 0.2

var _zoom_level: Vector2 = zoom:
	get:
		return _zoom_level # TODOConverter40 Non existent get function 
	set(mod_value):
		_zoom_level = mod_value  # TODOConverter40 Copy here content of _set_zoom_level

var _drag := false
var _cursor_loc := Vector2.ZERO


func _input(event) -> void:
	if (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_WHEEL_UP):
			_set_zoom_level(_zoom_level + zoom_factor)
		if (event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
			_set_zoom_level(_zoom_level - zoom_factor)
	
	if(event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE):
		if(!_drag and event.pressed):
			_drag = true
			_cursor_loc = event.position
		elif(_drag and !event.pressed):
			_drag = false

	if(event is InputEventMouseMotion and _drag):
		var offset_position: Vector2 = (_cursor_loc - event.position) / 2
		position += offset_position

		_cursor_loc = event.position


func _set_zoom_level(value: Vector2) -> void:
	_zoom_level.x = clampf(value.x, min_zoom.x, max_zoom.x)
	_zoom_level.y = clampf(value.y, min_zoom.y, max_zoom.y)
	
	var tween := get_tree().create_tween()
	@warning_ignore(return_value_discarded)
	tween.tween_property(self, "zoom", _zoom_level, zoom_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
