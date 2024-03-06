@tool
class_name AbstractMotion
extends Resource


@export var is_update_direction: bool = true
@export_group("Animation")
@export var tween_transition: Tween.TransitionType
@export var tween_ease: Tween.EaseType

var characters_motion: BattleEnums.CharactersMotions
var duration: float


func _init(
			_is_update_direction: bool = true,
			_tween_ease: Tween.EaseType = Tween.EASE_IN,
			_tween_transition: Tween.TransitionType = Tween.TRANS_LINEAR) -> void:
	is_update_direction = _is_update_direction


func execute(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void:
	character.view_model.switch_motion(characters_motion)
	if is_update_direction:
		character.view_model.flip_to_specified_point(main_opponent.position)
	var additional_position: Vector3 = _create_additional_position(character, main_opponent, sub_targets)
	await character.movement_model.animate_move_to(additional_position, duration, tween_ease, tween_transition)


func _create_additional_position(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> Vector3:
	return Vector3.ZERO
