class_name PointerOfAssaultArrow
extends TextureRect


@export var _connection_point: Vector2 = size / 2

var connection_point: Vector2 :
	get: return _target_point + (_connection_point - pivot_offset).rotated(rotation)

var _target_point: Vector2 = size / 2


func draw(target_point: Vector2, angle_along_body: float) -> void:
	_target_point = target_point
	position = target_point - pivot_offset
	rotation = angle_along_body


func adjust(arc_end_angle: float) -> void:
	rotation = arc_end_angle
