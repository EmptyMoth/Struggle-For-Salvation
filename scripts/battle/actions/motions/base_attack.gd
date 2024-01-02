class_name BaseAttack
extends AbstractMotion


func _init(
			_characters_motions: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.ATTACK_1, 
			_duration: float = _DEFAULT_DURATION,
			_is_update_direction: bool = true) -> void:
	super(_characters_motions, _duration, _is_update_direction)


func _create_additional_position(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> Vector3:
	var moving_character: CharacterMovementModel = character.movement_model
	var new_position: Vector3 = main_opponent.movement_model.position - moving_character.position
	new_position = new_position.normalized() / 3
	return new_position
