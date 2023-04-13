class_name ArrowBodyOfAssault
extends Line2D


const _ARC_START_ANGLE_DEG: int = 90 - BaseArrowOfAssault.ARC_START_ANGLE_DEG
const _ARC_END_ANGLE_DEG: int = 90 + BaseArrowOfAssault.ARC_START_ANGLE_DEG
const _MAX_UNIT_BY_X: float = cos(deg_to_rad(_ARC_START_ANGLE_DEG))
const _OFFSET_UNIT_BY_Y: float = sin(deg_to_rad(_ARC_START_ANGLE_DEG))


func draw_body(start: Vector2, target: Vector2) -> void:
	var line_creation_direction: Vector2 = target - start
	position = start
	rotation = line_creation_direction.angle()
	_create_arc(line_creation_direction)


func _create_arc(line_creation_direction: Vector2) -> void:
	clear_points()
	for angle in range(_ARC_START_ANGLE_DEG, _ARC_END_ANGLE_DEG):
		var new_point: Vector2 = _create_point(deg_to_rad(angle), 
			line_creation_direction)
		add_point(new_point)

func _create_point(angle_rad: float, line_creation_direction: Vector2) -> Vector2:
	var radius: float = line_creation_direction.length() / 2
	var point: Vector2 = Vector2(cos(angle_rad), -sin(angle_rad) + _OFFSET_UNIT_BY_Y)
	point *= radius
	point.x /= _MAX_UNIT_BY_X
	point.x += radius
	point.y *= cos(line_creation_direction.angle())
	return point
