class_name CharacterMovementModel
extends CharacterBody3D


signal came_to_position

const SPEED: float = 5.0

var default_position: Vector3

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D


func _ready():
	set_physics_process(false)
	_navigation_setup.call_deferred()


func _physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	velocity = global_position.direction_to(next_path_position) * SPEED
	velocity.y = 0
	move_and_slide()


func to_left_of_character(character: Character) -> bool:
	return self.position.x < character.get_movement_model().position.x


func set_default_position(new_position: Vector3) -> void:
	default_position = new_position
	position = default_position


func get_current_position_on_camera() -> Vector2:
	return _get_position_on_camera(position)

func get_default_position_on_camera() -> Vector2:
	return _get_position_on_camera(default_position)


func move_to_default_position() -> void:
	move_to(default_position)


func move_to(new_position: Vector3) -> void:
	navigation_agent.set_target_position(new_position)
	await navigation_agent.navigation_finished
	came_to_position.emit()


func move_to_one_side(opponent: Character) -> void:
	move_to(opponent.get_movement_model().position)

func move_to_clash(opponent: Character) -> void:
	move_to((self.position + opponent.get_movement_model().position) / 2)


func _get_position_on_camera(position_3d: Vector3) -> Vector2:
	return get_viewport().get_camera_3d().unproject_position(position_3d)


func _navigation_setup():
	await NavigationServer3D.map_changed
	set_physics_process(true)
