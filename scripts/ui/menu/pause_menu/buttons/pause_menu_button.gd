extends Button


const _DEFAULT_FONT_SIZE: int = 32
const _HOVER_FONT_SIZE: int = 40
const _PRESS_FONT_SIZE: int = 36

const _DURATION_HOVER: float = 0.15
const _DURATION_PRESS: float = 0.05

var _tween: Tween


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)


func _on_mouse_entered() -> void:
	_animate_button(_HOVER_FONT_SIZE, _DURATION_HOVER)


func _on_mouse_exited() -> void:
	_animate_button(_DEFAULT_FONT_SIZE, _DURATION_HOVER)


func _on_button_down() -> void:
	_animate_button(_PRESS_FONT_SIZE, _DURATION_PRESS)


func _on_button_up() -> void:
	_animate_button(_HOVER_FONT_SIZE, _DURATION_PRESS)


func _animate_button(final_value: int, duration: float) -> void:
	if not is_inside_tree():
		return
	if _tween:
		_tween.kill()
	_tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	_tween.tween_property(self, "theme_override_font_sizes/font_size", final_value, duration)



