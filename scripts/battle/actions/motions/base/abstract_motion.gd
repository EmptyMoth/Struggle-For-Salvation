class_name AbstractMotion
extends Resource


static var DEFAULT: AbstractMotion


@export var characters_motions: BattleEnums.CharactersMotions
@export_range(0, 1, 0.01) var duration: float = 0.1
@export var is_update_direction: bool = true

@export_group("Animation")
@export var tween_transition: Tween.TransitionType
@export var tween_ease: Tween.EaseType


func _init(
			_characters_motions: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DEFAULT, 
			_duration: float = 0.1,
			_is_update_direction: bool = true,
			_tween_ease: Tween.EaseType = Tween.EASE_IN,
			_tween_transition: Tween.TransitionType = Tween.TRANS_LINEAR) -> void:
	characters_motions = _characters_motions
	duration = _duration
	is_update_direction = _is_update_direction


func execute(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void:
	var new_position: Vector3 = _create_new_position(character, main_opponent, sub_targets)
	await character.movement_model.animate_move_to(new_position, duration, tween_ease, tween_transition)


func _create_new_position(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> Vector3:
	return character.movement_model.position
