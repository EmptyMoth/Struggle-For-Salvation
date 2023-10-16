class_name BodyOfAssaultArrow
extends Line2D


const _POINT_COUNT: float = 45.0
const _ANGLE_ALONG_BODY: float = deg_to_rad(45)
const _ARC_START_ANGLE: float = PI/2 - _ANGLE_ALONG_BODY
const _ARC_END_ANGLE: float = PI/2 + _ANGLE_ALONG_BODY
const _STRETCHING_FACTOR_BY_X: float = cos(PI/2 - _ANGLE_ALONG_BODY)
const _DOWNING_FACTOR_BY_Y: float = sin(PI/2 - _ANGLE_ALONG_BODY)

var _arc_end_angle: float
var _arrow_line: Vector2


func set_arrow_line(arrow_line: Vector2) -> void:
	_arrow_line = arrow_line


func draw(end_point: Vector2) -> void:
	clear_points()
	_arc_end_angle = _get_deflection_angle(end_point)
	for i in _POINT_COUNT + 1:
		var angle: float = lerpf(_ARC_START_ANGLE, _arc_end_angle, i / _POINT_COUNT)
		var new_point: Vector2 = _create_point(angle)
		add_point(new_point)


func get_angle_along_body(weight: float) -> float:
	var angle: float = lerpf(_ARC_START_ANGLE, _ARC_END_ANGLE, weight)
	return _get_angle_along_body(angle)


func get_adjusted_angle_along_body() -> float:
	var angle: float = lerpf(_ARC_START_ANGLE, _arc_end_angle, 1.0 - 3 / _POINT_COUNT)
	return _get_angle_along_body(angle)


func get_point_on_arc(weight: float) -> Vector2:
	var point_angle: float = lerpf(_ARC_START_ANGLE, _ARC_END_ANGLE, weight)
	return _create_point(point_angle)


func _create_point(angle: float) -> Vector2:
	var radius: float = _arrow_line.length() / 2
	var correct_x: float = cos(angle) / _STRETCHING_FACTOR_BY_X
	var correct_y: float = -sin(angle) + _DOWNING_FACTOR_BY_Y
	var point: Vector2 = radius * Vector2(correct_x, correct_y)
	point.x -= radius
	point.y *= -cos(_arrow_line.angle())
	return point.rotated(-PI)


func _get_deflection_angle(point: Vector2) -> float:
	var radius: float = _arrow_line.length() / 2
	point = point.rotated(PI)
	point.x += radius
	point.x /= radius
	point.x *= _STRETCHING_FACTOR_BY_X
	return acos(point.x)


func _get_angle_along_body(angle: float) -> float:
	return (angle - PI/2) * cos(_arrow_line.angle())
