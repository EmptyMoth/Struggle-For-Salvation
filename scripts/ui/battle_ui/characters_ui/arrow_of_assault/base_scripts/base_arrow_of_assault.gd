class_name BaseArrowOfAssault
extends Control


const ARC_START_ANGLE_DEG: int = 45
const ARC_START_ANGLE_RAD: float = deg_to_rad(ARC_START_ANGLE_DEG)

@onready var _body: ArrowBodyOfAssault = $Body
@onready var _pointer_at_end: ArrowPointerOfAssault = $PointerAtEnd


func draw_arrow(target: Vector2) -> void:
	_draw_arrow(target)


func _draw_arrow(target: Vector2) -> void:
	_pointer_at_end.draw_pointer(target, target)
	
	var new_start: Vector2 = Vector2.ZERO
	var new_target: Vector2 = _pointer_at_end.get_connection_point_position()
	_body.draw_body(new_start, new_target)
