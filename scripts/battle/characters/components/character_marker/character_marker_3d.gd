class_name CharacterMarker3D
extends CharacterBody3D


const SPEED: float = 5.0
const _POINT_INDENTATION: int = 100

var start_position: Vector3


func _physics_process(_delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	@warning_ignore("unused_variable")
	var is_colided: bool = move_and_slide()


func to_left_of_character(character: CharacterMarker3D) -> bool:
	return self.position.x < character.position.x


func get_point_for_clash(opponent: CharacterMarker3D) -> Vector3:
	@warning_ignore("integer_division")
	return _get_indented_point((self.position + opponent.position) / 2, 
			int(_POINT_INDENTATION / 2), opponent)


func get_point_for_one_sided(opponent: CharacterMarker3D) -> Vector3:
	return _get_indented_point(opponent.position, _POINT_INDENTATION, opponent)


func _get_indented_point(
			point: Vector3, 
			point_indentation: int,
			opponent: CharacterMarker3D) -> Vector3:
	return point + (point_indentation * Vector3.LEFT \
			if to_left_of_character(opponent) \
			else point_indentation * Vector3.RIGHT)


func set_start_position(new_position: Vector3) -> void:
	start_position = new_position
	position = start_position


func get_current_position_on_camera() -> Vector2:
	return _get_position_on_camera(position)


func get_start_position_on_camera() -> Vector2:
	return _get_position_on_camera(start_position)


func return_to_starting_position() -> void:
	_move_to_position(start_position, 1)


func move_to_new_position(new_position: Vector3) -> void:
	_move_to_position(new_position, 0.5)


func _get_position_on_camera(current_position: Vector3) -> Vector2:
	var viewport: Viewport = get_viewport()
	return viewport.get_camera_3d().unproject_position(current_position) \
		if is_instance_valid(viewport) \
		else Vector2.ZERO


func _move_to_position(new_position: Vector3, duration: float) -> void:
	var tween: Tween = get_tree().create_tween()
	@warning_ignore("return_value_discarded")
	tween.tween_property(self, "position", new_position, duration)
