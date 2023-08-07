class_name BaseArrowOfPlayerAssault
extends BaseArrowOfOneSideAttack


func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		var mouse_cursor_axis: Vector2 = get_global_mouse_position() - global_position
		_draw_arrow(mouse_cursor_axis)
