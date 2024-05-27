@tool
class_name KnockbackMotion
extends AbstractMotion


@export var _motion: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.STUN :
	set(value):
		_motion = value
		characters_motion = value
@export_range(0, 5, 0.5, "or_greater") var knockback_power: float = 3



func _init(
			_knockback_power: float = 3,
			_characters_motion: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DAMAGE, 
			_is_update_direction: bool = true,
			_tween_ease: Tween.EaseType = Tween.EASE_OUT,
			_tween_transition: Tween.TransitionType = Tween.TRANS_QUAD) -> void:
	super(_is_update_direction, _tween_ease, _tween_transition)
	knockback_power = _knockback_power
	_motion = _characters_motion


func _create_additional_position(character: Character, main_opponent: Character, _sub_targets: Array[Character] = []) -> Vector3:
	var moving_character: CharacterMovementModel = character.movement_model
	var new_position: Vector3 = moving_character.position - main_opponent.movement_model.position
	new_position = knockback_power / 5.0 * new_position.normalized()
	return new_position
