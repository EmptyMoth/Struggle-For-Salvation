class_name CharacterMovementModel
extends CharacterBody3D


signal anim_came_to_position
signal came_to_position
signal began_to_move
signal finished_to_move

const MOVEMENT_SPEED: float = 5.0

var model: Character
var default_position: Vector3
var is_animation_move: bool = false
var acceleration: float = 0

var _target_position: Vector3
var _is_move: bool = false

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D


func _ready() -> void:
	if NavigationServer3D.map_is_active(navigation_agent.get_navigation_map()):
		return
	set_physics_process(false)
	await NavigationServer3D.map_changed
	set_physics_process(true)


func _physics_process(delta: float) -> void:
	if is_animation_move:
		var collision: KinematicCollision3D = move_and_collide(velocity * delta)
		if collision != null:
			velocity = velocity.bounce(collision.get_normal())
	#elif not navigation_agent.is_navigation_finished():
		#var next_path_position: Vector3 = navigation_agent.get_next_path_position()
		#velocity = position.direction_to(next_path_position) * MOVEMENT_SPEED
		#prints(navigation_agent.target_position, next_path_position)
		#move_and_slide()


func to_left_of(character: Character) -> bool:
	return self.position.x < character.get_movement_model().position.x


func set_default_position(new_position: Vector3) -> void:
	default_position = new_position
	set_to_default_position()

func set_to_default_position() -> void:
	position = default_position


func get_current_position_on_camera() -> Vector2:
	return _get_position_on_camera(position)

func get_default_position_on_camera() -> Vector2:
	return _get_position_on_camera(default_position)


func animate_move_to(
			additional_position: Vector3, 
			duration: float, 
			tween_ease: Tween.EaseType = Tween.EASE_IN,
			transition: Tween.TransitionType = Tween.TRANS_LINEAR) -> void:
	is_animation_move = true
	await get_tree().physics_frame
	velocity = additional_position / duration#2 * additional_position / duration
	acceleration = 1
	await get_tree().create_timer(duration).timeout
	#await get_tree().create_tween()\
			#.set_ease(tween_ease).set_trans(transition)\
			#.tween_property(self, "acceleration", 0.0, duration).from(1.0)\
			#.finished
	acceleration = 0
	is_animation_move = false
	anim_came_to_position.emit()


func move_to(new_position: Vector3) -> void:
	#navigation_agent.set_target_position(new_position)
	animate_move_to(new_position - position, (new_position - position).length() / MOVEMENT_SPEED)
	model.view_model.flip_to_specified_point(_get_position_on_camera(new_position))
	#await navigation_agent.navigation_finished
	await anim_came_to_position
	came_to_position.emit()


func move_to_one_side(opponent: Character) -> void:
	navigation_agent.path_desired_distance = 0.5
	await _move_to_position(opponent.get_movement_model().position - 0.5 * position.direction_to(opponent.get_movement_model().position))

func move_to_clash(opponent: Character) -> void:
	navigation_agent.path_desired_distance = 0.3
	await _move_to_position((self.position + opponent.get_movement_model().position) / 2  - 0.3 * position.direction_to(opponent.get_movement_model().position))


func _move_to_position(target_position: Vector3) -> void:
	began_to_move.emit()
	await move_to(target_position)
	finished_to_move.emit()


func _get_position_on_camera(position_3d: Vector3) -> Vector2:
	return get_viewport().get_camera_3d().unproject_position(position_3d)
