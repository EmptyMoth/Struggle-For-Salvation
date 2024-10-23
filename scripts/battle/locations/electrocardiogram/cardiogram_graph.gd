class_name CardiogramGraph
extends Line2D


const NUMBER_OF_PIXELS_RENDERED_PER_SECOND: float = 75


func _ready() -> void:
	clear_points()


func play_animation_of_drawing_graph(given_points: PackedVector2Array) -> void:
	clear_points()
	await _draw_graph(given_points)
	_erase_graph(given_points)


func _draw_graph(given_points: PackedVector2Array) -> void:
	add_point(given_points[0])
	for i: int in range(1, given_points.size()):
		var point: Vector2 = given_points[i - 1]
		add_point(point)
		await _move_point(i, i, given_points)


func _erase_graph(given_points: PackedVector2Array) -> void:
	for i: int in range(1, given_points.size()):
		await _move_point(0, i, given_points)
		remove_point(0)
	clear_points()


func _move_point(
			point_number: int, 
			current_point: int, 
			given_points: PackedVector2Array) -> void:
	var start_position: Vector2 = given_points[current_point - 1]
	var end_position: Vector2 = given_points[current_point]
	var time_to_draw: float = _get_time_to_draw(start_position, end_position)
	await get_tree().create_tween().bind_node(self)\
		.tween_method(_set_point_position.bind(point_number), 
			start_position, end_position, time_to_draw)\
		.finished


func _get_time_to_draw(start_position: Vector2, end_position: Vector2) -> float:
	var path: Vector2 = end_position - start_position
	var projection_on_x: float = path.length() * cos(path.angle())
	return projection_on_x / NUMBER_OF_PIXELS_RENDERED_PER_SECOND
	

func _set_point_position(new_position: Vector2, index: int) -> void:
	set_point_position(index, new_position)
