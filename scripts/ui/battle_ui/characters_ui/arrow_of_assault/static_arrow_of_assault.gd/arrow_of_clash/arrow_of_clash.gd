class_name ArrowOfClash
extends BaseArrowOfAssault


@onready var _pointer_at_beginning: ArrowPointerOfAssault = $PointerAtBeginning


func _draw_arrow(target: Vector2) -> void:
	_pointer_at_beginning.draw_pointer(Vector2.ZERO, target)
	_pointer_at_end.draw_pointer(target, target)
	
	var new_start: Vector2 = _pointer_at_beginning.get_connection_point_position()
	var new_target: Vector2 = _pointer_at_end.get_connection_point_position()
	_body.draw_body(new_start, new_target)
