class_name MotionsStop
extends AbstractMotion


static var DEFAULT: MotionsStop = MotionsStop.new()


func _init(
			_duration: float = _DEFAULT_DURATION,
			_is_update_direction: bool = true,
			_characters_motions: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DEFAULT) -> void:
	super(_characters_motions, _duration, _is_update_direction)


func execute(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void:
	if is_update_direction:
		character.view_model.flip_to_specified_point(main_opponent.view_model.position)
	character.view_model.switch_motion(characters_motion)
	await GlobalParameters.get_tree().create_timer(duration).timeout