class_name ArrowPointerOfAssault
extends TextureRect


const _ANGLE_ALONG_BODY: float = BaseArrowOfAssault.ARC_START_ANGLE_RAD

@export var _connection_point: Vector2 = size / 2

var real_pivot_offset = pivot_offset * scale
var offset_after_scaling = pivot_offset * (Vector2.ONE - scale)


func draw_pointer(new_position: Vector2, target: Vector2) -> void:
	position = new_position - real_pivot_offset - offset_after_scaling
	var angle_along_body: float = _ANGLE_ALONG_BODY * cos(target.angle())
	rotation = target.angle()
	rotation += -angle_along_body if flip_h else angle_along_body


func get_connection_point_position() -> Vector2:
	var pivot_offset_position: Vector2 = position + real_pivot_offset + offset_after_scaling
	var auxiliary_vector: Vector2 = (_connection_point - real_pivot_offset).rotated(rotation)
	var connection_point_position: Vector2 = pivot_offset_position + auxiliary_vector
	return connection_point_position
