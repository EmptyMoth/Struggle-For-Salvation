class_name PointerOfAssaultArrow
extends TextureRect


@export var _connection_point: Vector2 = size / 2


func draw(initial_position: Vector2, target_point: Vector2) -> void:
	position = target_point - pivot_offset
	var arrow_line: Vector2 = target_point - initial_position
	var angle_along_body: float = BodyOfAssaultArrow.ANGLE_ALONG_BODY_RAD * cos(arrow_line.angle())
	rotation = arrow_line.angle() + angle_along_body


func get_connection_point() -> Vector2:
	var pivot_offset_position: Vector2 = position + pivot_offset
	var auxiliary_vector: Vector2 = (_connection_point - pivot_offset).rotated(rotation)
	var connection_point_position: Vector2 = pivot_offset_position + auxiliary_vector
	return connection_point_position
