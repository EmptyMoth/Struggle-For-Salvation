extends HBoxContainer


const _SPEEDLINE_SEGMENT_PACKED: PackedScene = preload("res://scenes/ui/battle/speedline/components/speedline/speedline_segment.tscn")

@export var _line_gradient: Gradient

@onready var _end_arrow: TextureRect = $Arrow
@onready var _start_segment: HBoxContainer = $StartSegment
@onready var _start_color: Color = _get_color_by_index(0, 1)


func set_speeds(sorted_speeds: Array[int]) -> void:
	_remove_segments()
	_add_segments(sorted_speeds)


func _remove_segments() -> void:
	for i in get_child_count() - 3:
		remove_child(get_child(2))


func _add_segments(sorted_speeds: Array[int]) -> void:
	var speeds_count: int = sorted_speeds.size()
	_start_segment.init(sorted_speeds[0], _start_color)
	for i in speeds_count - 1:
		i += 1
		var segment: HBoxContainer = _SPEEDLINE_SEGMENT_PACKED.instantiate()
		add_child(segment)
		segment.init(sorted_speeds[i], _get_color_by_index(i, speeds_count))
	_end_arrow.modulate = _get_color_by_index(speeds_count - 1, speeds_count)
	move_child(_end_arrow, -1)


func _get_color_by_index(current_index: int, speeds_count: float) -> Color:
	return _line_gradient.sample(current_index / speeds_count)
