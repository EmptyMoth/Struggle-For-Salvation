class_name MovingContainer
extends MarginContainer


const MARGIN_BOTTOM := "margin_bottom"
const MARGIN_LEFT := "margin_left"
const MARGIN_RIGHT := "margin_right"
const MARGIN_TOP := "margin_top"


func move_container_from(tween: Tween, moving_side: Side, 
			from: float, to: float, duration: float) -> MethodTweener:
	return tween.tween_method(change_margin.bind(moving_side), from, to, duration)


func move_container_from_current(tween: Tween, moving_side: Side, 
			to: float, duration: float) -> MethodTweener:
	return tween.tween_method(change_margin.bind(moving_side), 
			get_margin(moving_side), to, duration)


func change_margin(constant: int, side: Side) -> void:
	add_theme_constant_override(MovingContainer._get_margin_name(side), constant)


func get_margin(side: Side) -> int:
	return get_theme_constant(MovingContainer._get_margin_name(side))


static func _get_margin_name(side: Side) -> String:
	match side:
		SIDE_BOTTOM:
			return MARGIN_BOTTOM
		SIDE_LEFT:
			return MARGIN_LEFT
		SIDE_RIGHT:
			return MARGIN_RIGHT
	return MARGIN_TOP
