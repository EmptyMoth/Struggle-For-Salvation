class_name AbstractMotion
extends Resource


const DEFAULT_DURATION: float = 0.3

@export var characters_motion: BattleEnums.CharactersMotions
@export_range(0, 1, 0.01, "or_greater") var duration: float = 0.1
@export var is_update_direction: bool = true

@export_group("Animation")
@export var tween_transition: Tween.TransitionType
@export var tween_ease: Tween.EaseType


func _init(
			_characters_motion: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DEFAULT, 
			_duration: float = DEFAULT_DURATION,
			_is_update_direction: bool = true,
			_tween_ease: Tween.EaseType = Tween.EASE_IN,
			_tween_transition: Tween.TransitionType = Tween.TRANS_LINEAR) -> void:
	characters_motion = _characters_motion
	duration = _duration
	is_update_direction = _is_update_direction


func execute(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void:
	var additional_position: Vector3 = _create_additional_position(character, main_opponent, sub_targets)
	character.view_model.switch_motion(characters_motion)
	await character.movement_model.animate_move_to(additional_position, duration, tween_ease, tween_transition)
	if is_update_direction:
		character.view_model.flip_to_specified_point(main_opponent.view_model.position)


func _create_additional_position(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> Vector3:
	return Vector3.ZERO
