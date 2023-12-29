class_name Knockback
extends AbstractMotion


@export_range(0, 5, 0.5, "or_greater") var knockback_power: float = 3


static func _static_init() -> void:
	DEFAULT = Knockback.new()


func _init(
			_knockback_power: float = 3,
			_duration: float = 0.3,
			_characters_motions: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DAMAGE, 
			_is_update_direction: bool = true,
			_tween_ease: Tween.EaseType = Tween.EASE_OUT,
			_tween_transition: Tween.TransitionType = Tween.TRANS_QUAD) -> void:
	super(_characters_motions, _duration, _is_update_direction, _tween_ease, _tween_transition)
	knockback_power = _knockback_power


func _create_new_position(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> Vector3:
	var moving_character: CharacterMovementModel = character.movement_model
	var new_position: Vector3 = main_opponent.movement_model.position - moving_character.position
	new_position = knockback_power * new_position.normalized()
	return new_position
