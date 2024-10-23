@tool
class_name SettingHSlider
extends PanelContainer


signal value_changed(value: float)

@export var min_value: int = 0 :
	set(set_value):
		min_value = set_value
		_progress_bar.min_value = set_value
		_step = _max_distance / float(max_value - min_value)
		value = value
@export var max_value: int = 100 :
	set(set_value):
		max_value = set_value
		_progress_bar.max_value = set_value
		_max_value_label.text = str(set_value)
		_current_value_label.custom_minimum_size.x = _max_value_label.size.x
		_step = _max_distance / float(max_value - min_value)
		value = value
@export var value: int = -1 :
	set(set_value):
		if value == set_value or not is_node_ready():
			return
		
		set_value = clampi(set_value, min_value, max_value)
		if not _is_dragged:
			_grabber.position.x = clampi(set_value * _step, 0, _max_distance)
		
		value = set_value
		_progress_bar.value = value
		_current_value_label.text = str(value)
		value_changed.emit(value)

@export var step: int = 1 :
	set(set_value):
		step = set_value
		_progress_bar.step = set_value

@export_group("Connections")
@export var _progress_bar: ProgressBar
@export var _grabber: PanelContainer
@export var _max_value_label: Label
@export var _current_value_label: Label

static var _sound: SoundPeriod
var _sound2: SoundPeriod
var _sound3: FmodEvent

var _is_dragged: bool = false
var _max_distance: int
var _step: float
var _mouse_capture_point_x: int = 0


func _init() -> void:
	if _sound == null:
		_sound = SoundPeriod.new(SoundEvents.UISoundID.SCROLL_BUTTON, 0.25)


func _ready() -> void:
	_sound2 = SoundPeriod.new(SoundEvents.UISoundID.SCROLL_BUTTON, 0.25)
	_max_distance = size.x - _grabber.size.x
	_step = _max_distance / float(max_value - min_value)
	_current_value_label.custom_minimum_size.x = _max_value_label.size.x


func _process(_delta: float) -> void:
	if not _is_dragged:
		return
	
	var new_mouse_position_x: int = get_local_mouse_position().x - _mouse_capture_point_x
	var correct_position: int = clampi(new_mouse_position_x, 0, _max_distance)
	if _grabber.position.x != correct_position:
		_sound.play()
	_grabber.position.x = correct_position
	value = correct_position / _step


func _on_button_button_down() -> void:
	_sound3 = SoundEvents.create_event(SoundEvents.UISoundID.SCROLL_BUTTON)
	_is_dragged = true
	_mouse_capture_point_x = _grabber.get_local_mouse_position().x

func _on_button_button_up() -> void:
	_is_dragged = false


func _on_sort_children() -> void:
	_grabber.position.x = clampi(value * _step, 0, _max_distance)
